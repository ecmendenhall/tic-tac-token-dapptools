import { useCurrentTurn } from "../hooks/contracts";

interface Props {
  gameId: string | undefined;
}

const CurrentTurn = ({ gameId } : Props) => {
  const currentTurn = useCurrentTurn(gameId);

  return (
    <div className="text-center my-8">
      {currentTurn && <p>{currentTurn}'s turn</p>}
    </div>
  );
};

export default CurrentTurn;
