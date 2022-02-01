import { useBlockNumber } from "@usedapp/core";

const CurrentBlock = () => {
  const currentBlock = useBlockNumber();

  return (
    <div className="fixed bottom-2 left-2 mb-0 z-50">
      {currentBlock && <p>Block: {currentBlock}</p>}
    </div>
  );
};

export default CurrentBlock;
