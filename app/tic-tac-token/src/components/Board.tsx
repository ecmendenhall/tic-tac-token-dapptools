import { useBoard } from "../hooks/contracts";
import { useState } from "react";

export type Marker = "X" | "O" | "";

interface Props {
  gameId: string | undefined;
  selectedSpace?: number;
  onSelectedSpace: (index: number) => void;
  currentTurn: Marker;
  winner: Marker;
}

const Board = ({
  gameId,
  onSelectedSpace,
  selectedSpace,
  currentTurn,
  winner,
}: Props) => {
  const board = useBoard(gameId);

  const onSquareClick = (marker: Marker, idx: number) => {
    if (marker === "") {
      onSelectedSpace(idx);
    }
  };

  const getClassName = (marker: Marker, idx: number) => {
    const baseClass =
      "group w-32 h-32 text-4xl text-center flex items-center justify-center border cursor-pointer";
    if (idx == selectedSpace && !winner) {
      return `${baseClass} border-purple-400 border-4`;
    } else {
      return `${baseClass} border-blue-300`;
    }
  };

  const getHoverClassName = (marker: Marker, idx: number) => {
    if (marker === "" && !winner) {
      return "group-hover:block hidden text-gray-400";
    } else {
      return "hidden";
    }
  };

  return (
    <div>
      <div className="grid grid-cols-3 w-96 bg-white">
        {board &&
          board.map((marker: Marker, idx: number) => {
            return (
              <div
                key={idx}
                className={getClassName(marker, idx)}
                onClick={() => onSquareClick(marker, idx)}
              >
                <span>{marker}</span>
                <span className={getHoverClassName(marker, idx)}>
                  {currentTurn}
                </span>
              </div>
            );
          })}
      </div>
    </div>
  );
};

export default Board;
