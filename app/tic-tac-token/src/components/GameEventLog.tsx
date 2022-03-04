import {
  shortenIfAddress,
  useEthers,
} from "@usedapp/core";
import { formatUnits } from "ethers/lib/utils";

import {
  useGameHistory,
} from "../hooks/contracts";

interface Props {
  gameId?: string;
}


const GameEventLog = ({ gameId }: Props) => {
  const gameEvents = useGameHistory(gameId);

  return (
    <div>
      <ul>
        {gameEvents.map((event) => {
          return (
            event && (
              <li>
                Player {shortenIfAddress(event.player)} marked space{" "}
                {formatUnits(event.position, "wei")} with {event.symbol}
              </li>
            )
          );
        })}
      </ul>
    </div>
  );
};

export default GameEventLog;
