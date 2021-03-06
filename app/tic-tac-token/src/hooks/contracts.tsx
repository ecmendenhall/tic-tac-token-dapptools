import { EtherscanProvider } from "@ethersproject/providers";
import {
  useBlockNumber,
  useContractCall,
  useContractFunction,
  useEthers,
} from "@usedapp/core";
import { getDefaultProvider, BigNumber, Contract, ethers } from "ethers";
import { parseUnits } from "ethers/lib/utils";
import { useEffect, useState } from "react";
import { Marker } from "../components/Board";
import contracts, { getContracts } from "../config/contracts";

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
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const [board] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "board",
    args: [gameId],
  }) ?? [[]];
  return board.map(numberToMarker);
}

export function useCurrentTurn(gameId: string | undefined) {
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const [turn] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "currentTurn",
    args: [gameId],
  }) ?? [BigNumber.from(0)];
  return numberToMarker(turn);
}

export function useWinner(gameId: string | undefined) {
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const [winner] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "winner",
    args: [gameId],
  }) ?? [BigNumber.from(0)];
  return numberToMarker(winner);
}

export function useGame(gameId: string | undefined) {
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const [game] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "games",
    args: [gameId],
  }) ?? [[]];
  const [playerX, playerO, turns] = game;
  return { playerX, playerO, turns };
}

export function useGamesByAddress(address: string | null | undefined) {
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const [games] = useContractCall({
    abi: contracts.game.abi,
    address: contracts.game.address,
    method: "getGamesByAddress",
    args: [address],
  }) ?? [[]];
  return games;
}

interface MarkSpaceEvent {
  player: string;
  position: BigNumber;
  symbol: Marker;
}

export function useGameHistory(gameId: string | undefined) {
  const { library, chainId } = useEthers();
  const contracts = getContracts(chainId);
  const blockNumber = useBlockNumber();

  const [gameHistory, setGameHistory] = useState<
    (MarkSpaceEvent | undefined)[]
  >([]);

  useEffect(() => {
    if (gameId && library) {
      const loadGameHistory = async () => {
        const game = new Contract(
          contracts.game.address,
          contracts.game.abi,
          library
        );
        const eventLogs = await game.queryFilter(
          game.filters.MarkSpace(null, parseUnits(gameId, "wei"))
        );
        console.log("EventLogs: ", eventLogs);
        const events = eventLogs.map((log) => {
          if (log.args) {
            return {
              player: log.args.player,
              position: log.args.position,
              symbol: numberToMarker(log.args.symbol),
            };
          }
        });
        console.log("Events: ", events);
        setGameHistory(events);
      };
      loadGameHistory();
    }
  }, [gameId, library, blockNumber]);

  return gameHistory;
}

export function useNewGame() {
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
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
  const { chainId } = useEthers();
  const contracts = getContracts(chainId);
  const contract = new Contract(
    contracts.game.address,
    contracts.game.abi,
    provider
  );
  return useContractFunction(contract, "markSpace", {
    transactionName: "Mark Space",
  });
}
