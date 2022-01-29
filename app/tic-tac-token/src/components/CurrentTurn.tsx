import { useCurrentTurn } from '../hooks';

const CurrentTurn = () => {
  const currentTurn = useCurrentTurn();
  
  return <div>{currentTurn && <p>Current turn: {currentTurn}</p>}</div>;
};

export default CurrentTurn;