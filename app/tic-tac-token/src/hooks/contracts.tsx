import { useContractCall, useContractFunction } from "@usedapp/core";
import { getDefaultProvider, BigNumber, Contract } from "ethers";
import { Marker } from "../components/Board";
import contracts from "../config/contracts";

const provider = getDefaultProvider();

const numberToMarker = (number: BigNumber): Marker => {
  if (number.eq(1)) {
    return "X";
  } else if (number.eq(2)) {
    return "O";
  } else {
    return "";
  }
};

export function useBoard(gameId: string | undefined) {
  const [board] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "board",
    args: [gameId],
  }) ?? [[]];
  return board.map(numberToMarker);
}

export function useCurrentTurn(gameId: string | undefined) {
  const [turn] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "currentTurn",
    args: [gameId],
  }) ?? [BigNumber.from(0)];
  return numberToMarker(turn);
}

export function useWinner(gameId: string | undefined) {
  const [winner] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "winner",
    args: [gameId],
  }) ?? [BigNumber.from(0)];
  return numberToMarker(winner);
}

export function useGame(gameId: string | undefined) {
  const [game] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "games",
    args: [gameId],
  }) ?? [[]];
  const [playerX, playerO, turns] = game;
  return { playerX, playerO, turns };
}

export function useNewGame() {
  const contract = new Contract(
    contracts.game.address,
    contracts.game.abi,
    provider
  );
  return useContractFunction(contract, "newGame", {
    transactionName: "New Game",
  });
}

export function useMarkSpace() {
  const contract = new Contract(
    contracts.game.address,
    contracts.game.abi,
    provider
  );
  return useContractFunction(contract, "markSpace", {
    transactionName: "Mark Space",
  });
}
