import Balances from "../components/Balances";
import Games from "../components/Games";
import FullPage from "../layouts/FullPage";

const Home = () => {
  return (
    <FullPage>
      <Games />
      <Balances />
    </FullPage>
  );
};

export default Home;
