import Balances from "../components/Balances";
import FullPage from "../layouts/FullPage";
import GameDetail from "../components/GameDetail";

const Game = () => {
  return (
    <FullPage>
      <GameDetail />
      <Balances />
    </FullPage>
  );
};

export default Game;
