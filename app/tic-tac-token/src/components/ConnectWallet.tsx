import { shortenAddress, shortenIfAddress, useEthers } from "@usedapp/core";

const ConnectWallet = () => {
  const { activateBrowserWallet, account } = useEthers();

  const connectedMessage = () => {
      return `Account: ${shortenIfAddress(account)}`
  }
  
  return (
    <div>
      <button onClick={() => activateBrowserWallet()}>{ account ? connectedMessage() : 'Connect' }</button>
    </div>
  );
};

export default ConnectWallet;