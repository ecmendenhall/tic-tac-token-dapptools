import { useBlockNumber } from "@usedapp/core";

const CurrentBlock = () => {
  const currentBlock = useBlockNumber();
  
  return <div>{currentBlock && <p>Block: {currentBlock}</p>}</div>;

};

export default CurrentBlock;