import { useCurrentTurn } from "../hooks/contracts";

const CurrentTurn = () => {
  const currentTurn = useCurrentTurn();

  return (
    <div className="text-center my-8">
      {currentTurn && <p>{currentTurn}'s turn</p>}
    </div>
  );
};

export default CurrentTurn;
