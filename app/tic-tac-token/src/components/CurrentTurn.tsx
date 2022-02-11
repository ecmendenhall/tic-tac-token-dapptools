import { Marker } from "./Board";

interface Props {
  gameId: string | undefined;
  currentTurn: Marker;
  winner: Marker;
}

const CurrentTurn = ({ gameId, currentTurn, winner }: Props) => {
  return (
    <div className="text-center my-4">
      {winner && <p>{winner} wins!</p>}
      {currentTurn && !winner && <p>{currentTurn}'s turn</p>}
    </div>
  );
};

export default CurrentTurn;
