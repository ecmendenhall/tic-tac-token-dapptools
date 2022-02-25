import { formatEther, formatUnits } from "ethers/lib/utils";
import { useEthers, useEtherBalance, useTokenBalance } from "@usedapp/core";
import contracts, { getContracts } from "../config/contracts";

const Balances = () => {
  const { chainId, account } = useEthers();
  const contracts = getContracts(chainId);
  const etherBalance = useEtherBalance(account);
  const tttBalance = useTokenBalance(contracts.token.address, account);
  const nftBalance = useTokenBalance(contracts.nft.address, account);

  return (
    <div className="fixed top-12 left-12 bg-blue-50 rounded-md shadow p-2">
      {etherBalance && <p><strong>ETH:</strong> {formatEther(etherBalance).slice(0, 6)}</p>}
      {tttBalance && <p><strong>TTT:</strong> {formatEther(tttBalance)}</p>}
      {nftBalance && <p><strong>Games:</strong> {formatUnits(nftBalance, "wei")}</p>}
    </div>
  );
};

export default Balances;
