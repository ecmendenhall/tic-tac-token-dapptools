import { useBoard } from '../hooks';

export type Marker = "X" | "O" | " ";

const Board = () => {
  const board = useBoard();

  return <div>{board && board.map((space : Marker, idx: number) => {
    return <div key={idx}>{space}</div>;
  }) }</div>
};

export default Board;