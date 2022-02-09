import { useNewGame } from "../hooks/contracts";
import { useEthers } from "@usedapp/core";
import React, { useState } from "react";
import Button from "./Button";

const NewGame = () => {
  const { account } = useEthers();

  const { state: newGameState, send: sendNewGame } = useNewGame();
  const [playerTwoAddress, setPlayerTwoAddress] = useState("");

  const onChange = (evt: React.FormEvent<HTMLInputElement>) => {
    setPlayerTwoAddress(evt.currentTarget.value);
  };

  return (
    <div>
      <label>
        <input
          className="p-2 shadow-inner mr-4"
          type="text"
          name="playerTwoAddress"
          placeholder="Opponent address"
          onChange={onChange}
        />
      </label>
      <Button onClick={() => sendNewGame(account, playerTwoAddress)}>
        New Game
      </Button>
    </div>
  );
};

export default NewGame;
