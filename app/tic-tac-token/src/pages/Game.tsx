import Balances from "../components/Balances";
import Board from "../components/Board";
import CurrentTurn from "../components/CurrentTurn";
import MarkSpace from "../components/MarkSpace";
import FullPage from "../layouts/FullPage";
import { useParams } from "react-router-dom";

const Game = () => {
  const { id: gameId } = useParams();

  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <div>
          <h2 className="text-center">Game #{gameId}</h2>
          <Board gameId={gameId} />
          <CurrentTurn gameId={gameId} />
          <MarkSpace gameId={gameId} />
        </div>
      </div>
      <Balances />
    </FullPage>
  );
};

export default Game;