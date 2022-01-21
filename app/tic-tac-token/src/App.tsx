import './App.css';
import { useBlockNumber, useEtherBalance, useEthers, useTokenBalance } from '@usedapp/core';
import { formatEther, formatUnits } from '@ethersproject/units'
import { useBoard } from './hooks';

export function App() {
  const { activateBrowserWallet, account } = useEthers()
  const etherBalance = useEtherBalance(account)
  const tttBalance = useTokenBalance("0x61487d9F293eeeD1607c8049243d946Ed61621Fb", account);
  const nftBalance = useTokenBalance("0xB798d7715aB74F0141815fA27Db7445f67806018", account);
  const blockNumber = useBlockNumber();
  const board = useBoard();

  return (
    <div>
      <div>
        <button onClick={() => activateBrowserWallet()}>Connect</button>
      </div>
      {account && <p>Account: {account}</p>}
      {etherBalance && <p>Balance: {formatEther(etherBalance)}</p>}
      {tttBalance && <p>Balance: {formatEther(tttBalance)}</p>}
      {nftBalance && <p>Balance: {formatUnits(nftBalance, "wei")}</p>}
      {blockNumber && <p>Block: {blockNumber}</p>}
      {board && <p>Board: {JSON.stringify(board)}</p>}
    </div>
  )
}

export default App;