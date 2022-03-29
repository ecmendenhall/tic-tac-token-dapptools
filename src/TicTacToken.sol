// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";
import "./interfaces/INFT.sol";

contract TicTacToken {
    address public admin;
    address public playerX;
    address public playerO;
    uint256 public totalGames;

    uint256[9] public board;
    mapping(address => uint256) public totalWins;
    mapping(address => uint256) public totalPoints;

    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;
    uint256 internal constant POINTS_PER_WIN = 300 ether;
    uint256 internal nextGameId;
    mapping(address => uint256) internal winCountByAddress;
    mapping(address => uint256) internal pointCountByAddress;

    constructor(
        address _admin,
        address _playerX,
        address _playerO
    ) {
        admin = _admin;
        playerX = _playerX;
        playerO = _playerO;
        token = IToken(_token);
        nft = INFT(_nft);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Must be admin");
        _;
    }

    modifier onlyPlayer() {
        require(_validPlayer(msg.sender), "Unauthorized");
        _;
    }

    function markSpace(uint256 i) public {
        require(_validTurn(msg.sender), "Not your turn");
        require(_validSpace(i), "Invalid space");
        require(_emptySpace(i), "Already marked");
        turns++;
        board[i] = _getSymbol(msg.sender);
        if (winner() != 0) {
            totalGames += 1;
            address winnerAddress = _getAddress(winner());
            totalWins[winnerAddress] += 1;
            totalPoints[winnerAddress] += _pointsEarned();
        }
    }

    function _setSymbol(
        uint256 gameId,
        uint256 i,
        uint8 symbol
    ) internal {
        Game storage game = _game(gameId);
        if (symbol == X) {
            game.playerXBitmap = _setBit(game.playerXBitmap, i);
        }
        if (symbol == O) {
            game.playerOBitmap = _setBit(game.playerOBitmap, i);
        }
    }

    function _setBit(uint16 bitMap, uint256 i) internal pure returns (uint16) {
        return bitMap | (uint16(1) << uint16(i));
    }

    function board(uint256 gameId) external view returns (uint8[9] memory) {
        Game memory game = _game(gameId);
        uint16 playerXBitmap = game.playerXBitmap;
        uint16 playerOBitmap = game.playerOBitmap;
        uint16 nonEmptySpaces = playerXBitmap | playerOBitmap;
        uint8[9] memory boardArray;
        for (uint256 i = 0; i < 9; ) {
            if (_readBit(nonEmptySpaces, i) != 0) {
                if (_readBit(playerXBitmap, i) == 1) {
                    boardArray[i] = uint8(X);
                }
                if (_readBit(playerOBitmap, i) == 1) {
                    boardArray[i] = uint8(O);
                }
            }
            unchecked {
                ++i;
            }
        }
        return boardArray;
    }

    function currentTurn(uint256 gameID) public view returns (uint256) {
        return (_game(gameID).turns % 2 == 0) ? X : O;
    }

    function reset() public onlyAdmin {
        delete board;
    }

    function winner() public view returns (uint256) {
        return _checkWins();
    }

    function _pointsEarned() internal view returns (uint256) {
        uint256 moves;
        if (winner() == X) {
            moves = (turns + 1) / 2;
        }
        if (winner() == O) {
            moves = turns / 2;
        }
        return 600 - (moves * 100);
    }

    function _getAddress(uint256 symbol) internal view returns (address) {
        if (symbol == X) return playerX;
        if (symbol == O) return playerO;
        return address(0);
    }

    function _getSymbol(address player) internal view returns (uint256) {
        if (player == playerX) return X;
        if (player == playerO) return O;
        return EMPTY;
    }

    function _validPlayer(address caller) internal view returns (bool) {
        return caller == playerX || caller == playerO;
    }

    function _validSpace(uint256 i) internal pure returns (bool) {
        return i < 9;
    }

    function _validTurn(address player) internal view returns (bool) {
        return currentTurn() == _getSymbol(player);
    }

    function _readBit(uint16 bitMap, uint256 i) internal pure returns (uint16) {
        return bitMap & (uint16(1) << uint16(i));
    }

    function _emptySpace(uint256 gameId, uint256 i)
        internal
        view
        returns (bool)
    {
        Game memory game = _game(gameId);
        return _readBit(game.playerXBitmap | game.playerOBitmap, i) == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function _checkWins(uint256 gameId) internal view returns (uint256) {
        uint16[8] memory wins = [7, 56, 448, 292, 146, 73, 273, 84];
        Game memory game = _game(gameId);
        uint16 playerXBitmap = game.playerXBitmap;
        uint16 playerOBitmap = game.playerOBitmap;
        for (uint256 i = 0; i < wins.length; ) {
            if (wins[i] == playerXBitmap) {
                return X;
            } else if (wins[i] == playerOBitmap) {
                return O;
            }
            unchecked {
                ++i;
            }
        }
        return 0;
    }

    function winCount(address playerAddress) external view returns (uint256) {
        return winCountByAddress[playerAddress];
    }

    function pointCount(address playerAddress) external view returns (uint256) {
        return pointCountByAddress[playerAddress];
    }

    function _incrementWinCount(address playerAddress) private {
        unchecked {
            winCountByAddress[playerAddress]++;
        }
    }

    function _incrementPointCount(address playerAddress) private {
        unchecked {
            pointCountByAddress[playerAddress] += POINTS_PER_WIN;
        }
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
