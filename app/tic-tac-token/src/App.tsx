import './App.css';

import ConnectWallet from './components/ConnectWallet';
import NewGame from './components/NewGame';
import CurrentBlock from './components/CurrentBlock';
import CurrentTurn from './components/CurrentTurn';
import Balances from './components/Balances';
import Board from './components/Board';
import MarkSpace from './components/MarkSpace';


const App = () => {
  return (
    <div>
      <ConnectWallet />
      <NewGame />
      <Balances />
      <MarkSpace />
      <Board />
      <CurrentTurn />
      <CurrentBlock />
    </div>
  )
}

export default App;