import { useMarkSpace, useCurrentTurn } from "../hooks/contracts";
import { BigNumber } from "ethers";
import { parseUnits } from "ethers/lib/utils";
import React, { useState } from "react";
import Button from "./Button";

const MarkSpace = () => {
  const { state: markSpaceState, send: sendMarkSpace } = useMarkSpace();

  const [index, setIndex] = useState(BigNumber.from(0));
  const gameId = BigNumber.from(7);
  const symbol = useCurrentTurn();

  const symbolToNumber = (marker: string) => {
    if (marker === "X") {
      return BigNumber.from(1);
    } else if (marker === "O") {
      return BigNumber.from(2);
    } else {
      return BigNumber.from(0);
    }
  };

  const onChange = (evt: React.FormEvent<HTMLInputElement>) => {
    setIndex(parseUnits(evt.currentTarget.value, "wei"));
  };

  return (
    <div className="mb-4">
      <input
        className="p-2 shadow-inner mr-4"
        type="text"
        name="index"
        onChange={onChange}
      />
      <Button
        onClick={() => {
          console.log(gameId);
          console.log(index);
          console.log(symbolToNumber(symbol));
          sendMarkSpace(gameId, index, symbolToNumber(symbol));
        }}
      >
        Mark space
      </Button>
    </div>
  );
};

export default MarkSpace;
