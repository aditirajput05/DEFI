# DeFi Kingdom Clone on Avalanche

Welcome to the DeFi Kingdom clone project on the Avalanche CLI! This project replicates features from the original DeFi game, including Battling, Trading, and Exploring. It uses Solidity smart contracts to implement these features on an Avalanche EVM Subnet.

## Description

This project includes several smart contracts:

1. **ERC20**: Implements the ERC20 token standard with minting, burning, and transferring capabilities.
2. **Vault**: Acts as an in-game bank where players can deposit and withdraw tokens.
3. **EpicBattle**: Allows players to register, bid, and battle, with functionalities for tracking battle results and player progress.
4. **Trade_Bazzar**: Facilitates the creation, buying, and removal of asset listings.
5. **Explore_dungeon**: Manages exploration activities and rewards in different dungeons.

## Getting Started

### Executing the Program

1. **Install Remix IDE**: To run and deploy these contracts, use [Remix IDE](https://remix.ethereum.org/). 

2. **Download Files**: Clone or download the repository containing the smart contracts and upload them to Remix IDE.

3. **Set Up Avalanche CLI**: 
   - Install the Avalanche CLI tool. Follow the [official installation guide](https://docs.avax.network/build/avalanchego/avalanche-cli).
   - Create a custom subnet on your local machine.

### Creating a Custom Subnet

1. **Install Avalanche CLI Tool**:
   ```bash
   npm install -g avalanche-cli
   ```

2. **Create a New Subnet**:
   ```bash
   avalanche subnet create mySubnet
   ```

3. **Select EVM Subnet Option**:
   Choose the `SubnetEVM` option during the creation process.

4. **Deploy the Subnet**:
   ```bash
   avalanche subnet deploy mySubnet
   ```

5. **View Subnet Details**:
   The console will display the details about your newly created subnet.

6. **Connect to MetaMask**:
   - Add the custom subnet to MetaMask.
   - Use the Injected provider - MetaMask in Remix IDE.

## Functionality

### ERC20 Contract
- **Minting**: `mint(uint amount)`
- **Burning**: `burn(uint amount)`
- **Transferring**: `transfer(address recipient, uint amount)`
- **Approval**: `approve(address spender, uint amount)`
- **TransferFrom**: `transferFrom(address sender, address recipient, uint amount)`

### Vault Contract
- **Deposit**: `deposit(uint amount)`
- **Withdraw**: `withdraw(uint shares)`

### EpicBattle Contract
- **Register**: `register(uint256 strength)`
- **Bid**: `bid(uint256 amount, address opponent)`
- **Battle**: `battle(address opponent)`
- **Get Player**: `getPlayer(address player)`

### Trade_Bazzar Contract
- **Create Listing**: `createListing(address asset, uint256 price)`
- **Buy**: `buy(uint256 listingId)`
- **Remove Listing**: `removeListing(uint256 listingId)`
- **Get Listing**: `getListing(uint256 listingId)`
- **Get Seller Listings**: `getSellerListings(address seller)`
- **Get Recent Listings**: `getRecentListings(uint256 count)`

### Explore_dungeon Contract
- **Register**: `register()`
- **Explore**: `explore(DungeonType dungeonType)`
- **Get Explorer**: `getExplorer(address explorer)`
- **Get Explorer Count**: `getExplorerCount()`
- **Get Top Explorers**: `getTopExplorers(uint256 limit)`
- **Get All Explorers**: `getAllExplorers()`

## Working

1. **Deploy ERC20 Contract**: Compile and deploy the ERC20 contract first. Copy the contract address.

2. **Deploy Vault Contract**: Use the ERC20 contract address as a parameter for the Vault contract constructor.

3. **Deploy Other Contracts**: Deploy the EpicBattle, Trade_Bazzar, and Explore_dungeon contracts in sequence.

4. **Interact with Contracts**: Use Remix IDE or any compatible interface to interact with the deployed contracts.

## Authors

- **Akhanda Pal Biswas** - [LinkedIn]([https://www.linkedin.com/in/aditi-rajput-b9360720b/])

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
