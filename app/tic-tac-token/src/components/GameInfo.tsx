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
    <div>
      <p>
        PlayerX:{" "}
        <a href={getExplorerAddressLink(playerX, chainId || 1)}>
          {shortenIfAddress(playerX)}
        </a>
      </p>
      <p>
        PlayerO:{" "}
        <a href={getExplorerAddressLink(playerO, chainId || 1)}>
          {shortenIfAddress(playerO)}
        </a>
      </p>
      <p>Turns: {turns && formatUnits(turns, "wei")}</p>
    </div>
  );
};

export default GameInfo;
