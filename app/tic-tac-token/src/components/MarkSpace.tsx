import { useMarkSpace, useCurrentTurn } from "../hooks/contracts";
import { BigNumber } from "ethers";
import { parseUnits } from "ethers/lib/utils";
import React, { useState } from "react";
import Button from "./Button";
import { shortenIfAddress, useEthers } from "@usedapp/core";

interface Props {
  gameId: string | undefined;
  selectedSpace?: number;
  playerX: string;
  playerO: string;
  turns: number;
}

const MarkSpace = ({
  gameId,
  selectedSpace,
  playerX,
  playerO,
  turns,
}: Props) => {
  const { state: markSpaceState, send: sendMarkSpace } = useMarkSpace();
  const { account } = useEthers();

  const symbol = useCurrentTurn(gameId);

  const symbolToNumber = (marker: string) => {
    if (marker === "X") {
      return BigNumber.from(1);
    } else if (marker === "O") {
      return BigNumber.from(2);
    } else {
      return BigNumber.from(0);
    }
  };

  const validPlayer = () => {
    return account === playerX || account === playerO;
  };

  const currentTurn = () => {
    const currentPlayerAddress = symbol === "X" ? playerX : playerO;
    return account === currentPlayerAddress;
  };

  if (validPlayer() && currentTurn()) {
    return (
      <div className="mb-4 text-center">
        <Button
          onClick={() => {
            sendMarkSpace(gameId, selectedSpace, symbolToNumber(symbol));
          }}
        >
          Mark space
        </Button>
        <div className="my-2 text-red-500">{markSpaceState.errorMessage}</div>
      </div>
    );
  } else {
    return <div></div>;
  }
};

export default MarkSpace;
