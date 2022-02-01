import { shortenIfAddress, useEthers } from "@usedapp/core";
import Button from "./Button";

const ConnectWallet = () => {
  const { activateBrowserWallet, account } = useEthers();

  const connectedMessage = () => {
    return `Account: ${shortenIfAddress(account)}`;
  };

  return (
    <div className="fixed top-12 right-12 text-center">
      <Button onClick={() => activateBrowserWallet()}>
        {account ? connectedMessage() : "Connect"}
      </Button>
    </div>
  );
};

export default ConnectWallet;
