import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { Config, DAppProvider, Rinkeby, Hardhat } from "@usedapp/core";

import "./index.css";

const config: Config = {
  readOnlyChainId: Rinkeby.chainId,
  readOnlyUrls: {
    [Rinkeby.chainId]:
      "https://eth-rinkeby.alchemyapi.io/v2/binQCNYdryAKxeIakeJLx1YXSLQK-9cE",
  },
  multicallAddresses: {
    [Hardhat.chainId]: "0x5FbDB2315678afecb367f032d93F642f64180aa3"
  }
};

ReactDOM.render(
  <React.StrictMode>
    <DAppProvider config={config}>
      <App />
    </DAppProvider>
  </React.StrictMode>,
  document.getElementById("root")
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
