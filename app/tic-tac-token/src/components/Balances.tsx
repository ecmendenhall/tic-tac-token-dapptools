import { formatEther, formatUnits } from "ethers/lib/utils";
import { useEthers, useEtherBalance, useTokenBalance } from "@usedapp/core";
import contracts from "../config/contracts";

const Balances = () => {
  const { account } = useEthers();
  const etherBalance = useEtherBalance(account);
  const tttBalance = useTokenBalance(contracts.token.address, account);
  const nftBalance = useTokenBalance(contracts.nft.address, account);

  return (
    <div className="fixed top-12 left-12">
      {etherBalance && <p>ETH: {formatEther(etherBalance).slice(0, 6)}</p>}
      {tttBalance && <p>TTT: {formatEther(tttBalance)}</p>}
      {nftBalance && <p>Games: {formatUnits(nftBalance, "wei")}</p>}
    </div>
  );
};

export default Balances;
