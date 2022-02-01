import NewGame from "./components/NewGame";
import CurrentTurn from "./components/CurrentTurn";
import Balances from "./components/Balances";
import Board from "./components/Board";
import MarkSpace from "./components/MarkSpace";
import FullPage from "./layouts/FullPage";

const App = () => {
  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <div>
          <Board />
          <CurrentTurn />
          <MarkSpace />
          <NewGame />
        </div>
      </div>
      <Balances />
    </FullPage>
  );
};

export default App;
