// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EpicBattle {
    struct Player {
        address playerAddress;
        uint256 strength;
        uint256 battleCount;
        uint256 winCount;
        uint256 experience;
        uint256 level;
        uint256 bidAmount; // new variable to store the bid amount
    }

    mapping(address => Player) public players;

    event BattleResult(address indexed player1, address indexed player2, address winner);
    event LevelUp(address indexed player, uint256 newLevel);
    event BidPlaced(address indexed player, address indexed opponent, uint256 amount);
    event Registered(address indexed player);

    function register(uint256 _strength) external {
        require(players[msg.sender].playerAddress == address(0), "Player already registered");
        players[msg.sender] = Player(msg.sender, _strength, 0, 0, 0, 1, 0); // initialize bidAmount to 0
        emit Registered(msg.sender);
    }

    function bid(uint256 _amount, address _opponent) external payable {
    require(_amount > 0, "Bid amount must be greater than 0");
    require(_amount <= 500, "Bid amount must be less than or equal to 500");
    // require(msg.value == _amount, "Bid amount must match the sent Ether value");

    players[msg.sender].bidAmount = _amount; // store the bid amount

    emit BidPlaced(msg.sender, _opponent, _amount);

    // Automatically register player if they haven't already
    if (players[msg.sender].playerAddress == address(0)) {
        players[msg.sender] = Player(msg.sender, 10, 0, 0, 0, 1, 0); // initialize bidAmount to 0
        emit Registered(msg.sender);
    }

    // Automatically register opponent if they haven't already
    if (players[_opponent].playerAddress == address(0)) {
        players[_opponent] = Player(_opponent, 10, 0, 0, 0, 1, 0); // initialize bidAmount to 0
        emit Registered(_opponent);
    }

    }

    function battle(address _opponent) external {
        // Automatically register player if they haven't already
        if (players[msg.sender].playerAddress == address(0)) {
            players[msg.sender] = Player(msg.sender, 10, 0, 0, 0, 1, 0); // initialize bidAmount to 0
            emit Registered(msg.sender);
        }

        // Automatically register opponent if they haven't already
        if (players[_opponent].playerAddress == address(0)) {
            players[_opponent] = Player(_opponent, 10, 0, 0, 0, 1, 0); // initialize bidAmount to 0
            emit Registered(_opponent);
        }

        players[msg.sender].battleCount += 1;
        players[_opponent].battleCount += 1;

        address winner = _determineWinner(msg.sender, _opponent);
        players[winner].winCount += 1;
        players[winner].experience += 10;

        if (players[winner].experience >= players[winner].level * 100) {
            players[winner].level += 1;
            players[winner].experience = 0;
            emit LevelUp(winner, players[winner].level);
        }

        emit BattleResult(msg.sender, _opponent, winner);
    }

    function _determineWinner(address _player1, address _player2) private view returns (address) {
        uint256 rand = uint256(keccak256(abi.encodePacked(block.timestamp, _player1, _player2))) % 2;
        if (rand == 0) {
            if (players[_player1].strength > players[_player2].strength) {
                return _player1;
            } else {
                return _player2;
            }
        } else {
            if (players[_player2].strength > players[_player1].strength) {
                return _player2;
            } else {
                return _player1;
            }
        }
    }

    function getPlayer(address _player) external view returns (Player memory) {
        return players[_player];
    }
}
