import ConnectWallet from "../components/ConnectWallet";
import CurrentBlock from "../components/CurrentBlock";

interface Props {
  children: React.ReactNode;
}

const FullPage = ({ children }: Props) => {
  return (
    <div className="p-16 min-h-screen bg-gradient-to-tr from-blue-100 to-purple-100">
      <div className="mb-8">
        <h1 className="font-display font-bold text-6xl text-center">
          Tic Tac Token
        </h1>
      </div>
      <div>
        <ConnectWallet />
        {children}
      </div>
      <CurrentBlock />
    </div>
  );
};

export default FullPage;
