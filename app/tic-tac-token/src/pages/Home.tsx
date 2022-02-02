import Balances from "../components/Balances";
import Board from "../components/Board";
import CurrentTurn from "../components/CurrentTurn";
import MarkSpace from "../components/MarkSpace";
import FullPage from "../layouts/FullPage";

const Home = () => {
  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <h1>Home</h1>
      </div>
      <Balances />
    </FullPage>
  );
};

export default Home;