# Rock Paper Scissors on Ethereum

Two different versions of the popular [rock-paper-scissors](https://en.wikipedia.org/wiki/Rock-paper-scissors) game are implemented in the smart contract language [Solidity](http://solidity.readthedocs.org/en/latest/).

The naive version serves as a basic example to get started on using smart contracts. It also showcases a typical issue with smart contracts - privacy. One player makes a choice (e.g. "rock") which is then written into the blockchain. This allows the second player to make a winning choice by observing the choice of the first player.

The intermediate version splits the game into two phases: in the first phase the player is chosing not only rock paper or scissors but also a random string. The random strings have to be entered then in the reveal phase which allows for non-cheatable reaveling of the initial choice. If a player opts to not disclose their choice (because they know that they lost), the player that revealed first will be decleared the default winner after two minutes. This version still does not solve privacy as all transactions (in case of a public chain) are visible to everyone.

The advanced version is therefore outsourcing the hashing of the choice and the second random string to a frontend (here we do it in Node.JS). That allows the players to securely commit their hashes before revealing their choices. This version requires:

(1. node.js `sudo apt-get install nodejs-legacy`)
(2. npm `sudo apt-get install npm`)
2. install the webserver: `npm install http-server -g`
(3. on the machine which is exposing the geth RPC API (this is might not work on the ether.camp IDE as it requires a running and synced Ethereum node which takes several hours to donwload the blockchain) start geth via `geth --rpc --rpccorsdomain '*' --unlock 0xb21a357712d011149a1c2c452e8f9b021a72b42f console` (replace the account number with some account that has a few ether on it for testing and which you are going to user later on))
4. via IDE: replace:
- node URL with sandbox URL (in index.html)
- contract address (in index.html)
- contract ABI (in ABI.json)
5. run webserver in direction containing the index.html file: `http-server`
6. open the URL (change username) `https://sbuergel.by.ether.camp:8080/`


