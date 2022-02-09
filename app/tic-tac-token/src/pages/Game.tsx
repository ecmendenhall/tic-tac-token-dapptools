import Balances from "../components/Balances";
import Board from "../components/Board";
import CurrentTurn from "../components/CurrentTurn";
import MarkSpace from "../components/MarkSpace";
import FullPage from "../layouts/FullPage";
import { useParams } from "react-router-dom";
import GameInfo from "../components/GameInfo";
import { useState } from "react";
import { useCurrentTurn, useGame, useWinner } from "../hooks/contracts";

const Game = () => {
  const { id: gameId } = useParams();
  const currentTurn = useCurrentTurn(gameId);
  const gameState = useGame(gameId);
  const [selectedSpace, setSelectedSpace] = useState<number>();
  const winner = useWinner(gameId);

  const onSelectedSpace = (index: number) => {
    setSelectedSpace(index);
  };

  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <div>
          <h2 className="text-center">Game #{gameId}</h2>
          <Board
            gameId={gameId}
            onSelectedSpace={onSelectedSpace}
            selectedSpace={selectedSpace}
            currentTurn={currentTurn}
            winner={winner}
          />
          <CurrentTurn
            gameId={gameId}
            currentTurn={currentTurn}
            winner={winner}
          />
          <GameInfo {...gameState} />
          {!winner && (
            <MarkSpace
              gameId={gameId}
              selectedSpace={selectedSpace}
              {...gameState}
            />
          )}
        </div>
      </div>
      <Balances />
    </FullPage>
  );
};

export default Game;
