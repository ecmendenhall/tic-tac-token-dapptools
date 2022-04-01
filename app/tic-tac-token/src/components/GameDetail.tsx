import Board from "../components/Board";
import CurrentTurn from "../components/CurrentTurn";
import MarkSpace from "../components/MarkSpace";
import { useParams } from "react-router-dom";
import GameInfo from "../components/GameInfo";
import { useState } from "react";
import { useCurrentTurn, useGame, useWinner } from "../hooks/contracts";

const GameDetail = () => {
  const { id: gameId } = useParams();
  const currentTurn = useCurrentTurn(gameId);
  const gameState = useGame(gameId);
  const [selectedSpace, setSelectedSpace] = useState<number>();
  const winner = useWinner(gameId);

  const onSelectedSpace = (index: number) => {
    setSelectedSpace(index);
  };

  return (
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
      </div>
    </div>
  );
};

export default GameDetail;
