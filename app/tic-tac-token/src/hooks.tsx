import { useContractCall } from "@usedapp/core"
import { Interface } from "ethers/lib/utils";
import { BigNumber } from "ethers";

const abi = new Interface([
    "function board(uint256 game) returns (uint256[9] memory)"
]);

export const useBoard = () => {
    const [board] = useContractCall({
        abi: abi,
        address: "0x460b3323fd339ebC4c53e9AeB6161c5889F5eB07",
        method: "board",
        args: [1]
    }) ?? [];
    return board.map((n : BigNumber) => {
        if (n.eq(1)) {
            return "X"
        } else if (n.eq(2)) {
            return "O"
        } else {
            return " "
        }
    })
}