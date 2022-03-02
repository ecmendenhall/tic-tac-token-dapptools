import Balances from "../components/Balances";
import Board from "../components/Board";
import CurrentTurn from "../components/CurrentTurn";
import MarkSpace from "../components/MarkSpace";
import FullPage from "../layouts/FullPage";
import { useParams } from "react-router-dom";
import GameInfo from "../components/GameInfo";
import { useState } from "react";
import { useCurrentTurn, useGame, useGameHistory, useWinner } from "../hooks/contracts";
import { formatUnits } from "ethers/lib/utils";

const Game = () => {
  const { id: gameId } = useParams();
  const currentTurn = useCurrentTurn(gameId);
  const gameState = useGame(gameId);
  const [selectedSpace, setSelectedSpace] = useState<number>();
  const winner = useWinner(gameId);

  const gameEvents = useGameHistory(gameId);

  const onSelectedSpace = (index: number) => {
    setSelectedSpace(index);
  };

  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <div>
          <h2 className="text-center text-2xl">Game #{gameId}</h2>
          <Board
            gameId={gameId}
            onSelectedSpace={onSelectedSpace}
            selectedSpace={selectedSpace}
            currentTurn={currentTurn}
            winner={winner}
          />
          <GameInfo {...gameState} />
          <CurrentTurn
            gameId={gameId}
            currentTurn={currentTurn}
            winner={winner}
          />
          {!winner && (
            <MarkSpace
              gameId={gameId}
              selectedSpace={selectedSpace}
              {...gameState}
            />
          )}
          <div>Events: <ul>{gameEvents.map(e => <li>{e.args?.player} marked space {formatUnits(e.args?.position, "wei")} with an {formatUnits(e.args?.symbol, "wei")} </li>)}</ul></div>
        </div>
      </div>
      <Balances />
    </FullPage>
  );
};

export default Game;
