import { useContractCall, useContractFunction } from "@usedapp/core";
import { getDefaultProvider, BigNumber, Contract } from "ethers";
import contracts from "../config/contracts";

const provider = getDefaultProvider();

export function useBoard() {
  const [board] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "board",
    args: [7],
  }) ?? [[]];
  return board.map((square: BigNumber) => {
    if (square.eq(1)) {
      return "X";
    } else if (square.eq(2)) {
      return "O";
    } else {
      return " ";
    }
  });
}

export function useCurrentTurn() {
  const [turn] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "currentTurn",
    args: [7],
  }) ?? [BigNumber.from(0)];
  if (turn.eq(1)) {
    return "X";
  } else if (turn.eq(2)) {
    return "O";
  } else {
    return "";
  }
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
