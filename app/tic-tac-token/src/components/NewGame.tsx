import { useNewGame } from "../hooks";
import { useEthers } from "@usedapp/core";
import React, { useState } from "react";

const NewGame = () => {
  const { account } = useEthers();

  const { state: newGameState, send: sendNewGame } = useNewGame();
  const [playerTwoAddress, setPlayerTwoAddress] = useState("");

  const onChange = (evt: React.FormEvent<HTMLInputElement>) => {
      setPlayerTwoAddress(evt.currentTarget.value);
  }

  return (
    <div>
      <button onClick={() => sendNewGame(account, playerTwoAddress)}>New Game</button>
      <input type="text" name="playerTwoAddress" onChange={onChange} />
      {newGameState && <div>
      <p>New Game State: {newGameState.status}</p>
      <p>{newGameState.errorMessage}</p>
      </div>
      }
    </div>
  );
};

export default NewGame;
