import Balances from "../components/Balances";
import FullPage from "../layouts/FullPage";
import NewGame from "../components/NewGame";

const Home = () => {
  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <NewGame />
      </div>
      <Balances />
    </FullPage>
  );
};

export default Home;
