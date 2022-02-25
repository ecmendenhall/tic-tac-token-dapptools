import Balances from "../components/Balances";
import FullPage from "../layouts/FullPage";
import NewGame from "../components/NewGame";
import { useGamesByAddress } from "../hooks/contracts";
import { useEthers } from "@usedapp/core";
import { BigNumber } from "ethers";
import { Link } from "react-router-dom";

const Home = () => {
  const { account } = useEthers();
  const games = useGamesByAddress(account);

  return (
    <FullPage>
      <div className="flex flex-row justify-around text-lg">
        <div>
          <p>Your games:</p>
          <ul>
          { games.map((gameId: BigNumber) => {
            return <li><Link to={`/games/${gameId.toNumber()}`}>Game #{gameId.toNumber()}</Link></li>
          })}
          </ul>
        </div>
        <NewGame />
      </div>
      <Balances />
    </FullPage>
  );
};

export default Home;
