import { formatEther, formatUnits } from 'ethers/lib/utils';
import { useEthers, useEtherBalance, useTokenBalance } from "@usedapp/core";
import contracts from "../config/contracts";

const Balances = () => {
  const { account } = useEthers()
  const etherBalance = useEtherBalance(account)
  const tttBalance = useTokenBalance(contracts.token.address, account);
  const nftBalance = useTokenBalance(contracts.nft.address, account);

    return <div>{etherBalance && <p>Eth Balance: {formatEther(etherBalance)}</p>}
    {nftBalance && <p>Active games: {formatUnits(nftBalance, "wei")}</p>}
    {tttBalance && <p>TTT Balance: {formatEther(tttBalance)}</p>}
    </div>

};

export default Balances;