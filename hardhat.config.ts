import * as dotenv from "dotenv";

import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

import "./tasks/deploy";
import "./tasks/signer";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  paths: {
    sources: "./src"
  },
  networks: {
    mumbai: {
      url: process.env.MUMBAI_URL || "",
      accounts: {
        mnemonic: process.env.MUMBAI_MNEMONIC || ""
      } 
    },
    polygon: {
      url: process.env.POLYGON_URL || "",
      accounts: {
        mnemonic: process.env.POLYGON_MNEMONIC || ""
      } 
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

export default config;
