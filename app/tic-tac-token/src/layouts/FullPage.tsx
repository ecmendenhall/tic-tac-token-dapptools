import { useEthers } from "@usedapp/core";
import ConnectWallet from "../components/ConnectWallet";
import CurrentBlock from "../components/CurrentBlock";
import { supportedChain } from "../config/chains";

interface Props {
  children: React.ReactNode;
}

const FullPage = ({ children }: Props) => {
  const { chainId } = useEthers();

  return (
    <div className="p-16 min-h-screen bg-gradient-to-tr from-blue-100 to-purple-100">
      <div className="mb-8 text-center">
        <h1 className="font-display font-bold text-6xl">Tic Tac Token</h1>
      </div>
      <div>
        <ConnectWallet />
        { (chainId && supportedChain(chainId)) ? children : <p>The current network is not supported. Please connect to Polygon.</p>}
      </div>
      <CurrentBlock />
    </div>
  );
};

export default FullPage;
