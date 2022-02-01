import { useBoard } from "../hooks/contracts";

export type Marker = "X" | "O" | " ";

const Board = () => {
  const board = useBoard();
  return (
    <div className="grid grid-cols-3 w-96 bg-white">
      {board &&
        board.map((space: Marker, idx: number) => {
          return (
            <div
              key={idx}
              className="w-32 h-32 text-4xl text-center flex items-center justify-center border border-blue-300"
            >
              {space}
            </div>
          );
        })}
    </div>
  );
};

export default Board;
