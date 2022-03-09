// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";
import "./interfaces/INFT.sol";

contract TicTacToken {

    event NewGame(address indexed playerX, address indexed playerO, uint256 gameId);
    event MarkSpace(address indexed player, uint256 indexed gameId, uint256 position, uint256 symbol, uint8[9] board);
    event Win(address indexed winner, uint256 gameId);

    struct Game {
        address playerX;
        address playerO;
        uint8 turns;
        uint8[9] board;
    }

    mapping(uint256 => Game) public games;
    mapping(uint256 => uint256) public gameIdByTokenId;
    mapping(address => uint256[]) public gamesByAddress;
    IToken public immutable token;
    INFT public immutable nft;

    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    uint256 internal constant POINTS_PER_WIN = 300 ether;
    uint256 internal nextGameId;
    mapping(address => uint256) internal winCountByAddress;
    mapping(address => uint256) internal pointCountByAddress;

    constructor(address _token, address _nft) {
        token = IToken(_token);
        nft = INFT(_nft);
    }

    modifier requirePlayers(uint256 gameId) {
        require(
            msg.sender == _game(gameId).playerX ||
                msg.sender == _game(gameId).playerO,
            "Must be authorized player"
        );
        _;
    }

    function newGame(address _playerX, address _playerO) external {
        unchecked { nextGameId++; }
        uint256 id = nextGameId;
        games[id].playerX = _playerX;
        games[id].playerO = _playerO;

        gamesByAddress[_playerX].push(id);
        gamesByAddress[_playerO].push(id);
        mintGameToken(_playerX, _playerO);
        emit NewGame(_playerX, _playerO, id);
    }

    function getGamesByAddress(address playerAddress)
        external
        view
        returns (uint256[] memory)
    {
        return gamesByAddress[playerAddress];
    }

    function mintGameToken(address _playerX, address _playerO) internal {
        uint256 playerOToken = 2 * nextGameId;
        uint256 playerXToken = playerOToken - 1;
        nft.mint(_playerO, playerOToken);
        nft.mint(_playerX, playerXToken);
        gameIdByTokenId[playerOToken] = gameIdByTokenId[playerXToken] = nextGameId;
    }

    function markSpace(
        uint256 gameId,
        uint256 i,
        uint8 symbol
    ) external requirePlayers(gameId) {
        require(_validSpace(i), "Invalid space");
        require(_validSymbol(symbol), "Invalid symbol");
        require(_validTurn(gameId, symbol), "Not your turn");
        require(_emptySpace(gameId, i), "Already marked");
        unchecked { _game(gameId).turns++; }
        _game(gameId).board[i] = symbol;

        uint256 winningSymbol = winner(gameId);
        if (winningSymbol != 0) {
            address winnerAddress = _getPlayerAddress(gameId, winningSymbol);
            _incrementWinCount(winnerAddress);
            _incrementPointCount(winnerAddress);
            token.mintTTT(winnerAddress, POINTS_PER_WIN);
            emit Win(winnerAddress, gameId);
        }

        emit MarkSpace(msg.sender, gameId, i, symbol, _game(gameId).board);
    }

    function board(uint256 gameId) external view returns (uint8[9] memory) {
        return games[gameId].board;
    }

    function currentTurn(uint256 gameID) public view returns (uint256) {
        return (_game(gameID).turns % 2 == 0) ? X : O;
    }

    function winner(uint256 gameId) public view returns (uint256) {
        return _checkWins(gameId);
    }

    function _validSpace(uint256 i) internal pure returns (bool) {
        return i < 9;
    }

    function _validTurn(uint256 gameId, uint256 symbol)
        internal
        view
        returns (bool)
    {
        return currentTurn(gameId) == symbol;
    }

    function _emptySpace(uint256 gameId, uint256 i)
        internal
        view
        returns (bool)
    {
        return _game(gameId).board[i] == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function _checkWins(uint256 gameId) internal view returns (uint256) {
        uint256[8] memory wins = [
            _row(gameId, 0),
            _row(gameId, 1),
            _row(gameId, 2),
            _col(gameId, 0),
            _col(gameId, 1),
            _col(gameId, 2),
            _diag(gameId),
            _antiDiag(gameId)
        ];
        for (uint256 i; i < wins.length;) {
            if (wins[i] == 1) {
                return X;
            } else if (wins[i] == 8) {
                return O;
            }
            unchecked { ++i; }
        }
        return 0;
    }

    function _row(uint256 gameId, uint256 row) internal view returns (uint256) {
        require(row <= 2, "Invalid row");
        uint256 pos = row * 3;
        return
            _game(gameId).board[pos] *
            _game(gameId).board[pos + 1] *
            _game(gameId).board[pos + 2];
    }

    function _col(uint256 gameId, uint256 col) internal view returns (uint256) {
        require(col <= 2, "Invalid col");
        return
            _game(gameId).board[col] *
            _game(gameId).board[col + 3] *
            _game(gameId).board[col + 6];
    }

    function _diag(uint256 gameId) internal view returns (uint256) {
        return
            _game(gameId).board[0] *
            _game(gameId).board[4] *
            _game(gameId).board[8];
    }

    function _antiDiag(uint256 gameId) internal view returns (uint256) {
        return
            _game(gameId).board[2] *
            _game(gameId).board[4] *
            _game(gameId).board[6];
    }

    function winCount(address playerAddress) external view returns (uint256) {
        return winCountByAddress[playerAddress];
    }

    function pointCount(address playerAddress) external view returns (uint256) {
        return pointCountByAddress[playerAddress];
    }

    function _incrementWinCount(address playerAddress) private {
        unchecked { winCountByAddress[playerAddress]++; }
    }

    function _incrementPointCount(address playerAddress) private {
        unchecked { pointCountByAddress[playerAddress] += POINTS_PER_WIN; }
    }

    function _getPlayerAddress(uint256 gameId, uint256 playerSymbol)
        private
        view
        returns (address)
    {
        if (playerSymbol == X) {
            return _game(gameId).playerX;
        } else if (playerSymbol == O) {
            return _game(gameId).playerO;
        } else {
            return address(0);
        }
    }

    function _game(uint256 gameId) private view returns (Game storage) {
        return games[gameId];
    }
}
