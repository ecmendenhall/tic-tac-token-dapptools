import NewGame from "../components/NewGame";
import { useGamesByAddress } from "../hooks/contracts";
import { useEthers } from "@usedapp/core";
import { BigNumber } from "ethers";
import { Link } from "react-router-dom";

const Games = () => {
  const { account } = useEthers();
  const games = useGamesByAddress(account);

  return (
    <div className="flex flex-col justify-around text-lg">
      <div className="mb-4">
        <h2 className="mb-2 text-xl">Challenge an opponent to a new game:</h2>
        <NewGame />
      </div>
      {games.length > 0 && (
        <div className="mb-4">
          <h2 className="mb-2 text-xl">Your games:</h2>
          <ul>
            {games.map((gameId: BigNumber) => {
              return (
                <li>
                  <Link to={`/games/${gameId.toNumber()}`}>
                    Game #{gameId.toNumber()}
                  </Link>
                </li>
              );
            })}
          </ul>
        </div>
      )}
    </div>
  );
};

export default Games;
