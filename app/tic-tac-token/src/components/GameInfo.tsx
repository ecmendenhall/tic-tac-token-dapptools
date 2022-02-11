import { formatUnits } from "ethers/lib/utils";
import { BigNumber } from "ethers";
import {
  getExplorerAddressLink,
  shortenIfAddress,
  useEthers,
} from "@usedapp/core";

interface Props {
  playerX: string;
  playerO: string;
  turns: BigNumber;
}

const GameInfo = ({ playerX, playerO, turns }: Props) => {
  const { chainId } = useEthers();

  return (
    <div className="my-4">
      <p className="mb-1">
        Player X:{" "}
        <a href={getExplorerAddressLink(playerX, chainId || 1)}>
          <pre className="inline bg-blue-50 p-0.5">{shortenIfAddress(playerX)}</pre>
        </a>
      </p>
      <p>
        Player O:{" "}
        <a href={getExplorerAddressLink(playerO, chainId || 1)}>
          <pre className="inline bg-blue-50 p-0.5">{shortenIfAddress(playerO)}</pre>
        </a>
      </p>
    </div>
  );
};

export default GameInfo;
