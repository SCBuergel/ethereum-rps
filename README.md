# Rock Paper Scissors on Ethereum

Two different versions of the popular [rock-paper-scissors](https://en.wikipedia.org/wiki/Rock-paper-scissors) game are implemented in the smart contract language [Solidity](http://solidity.readthedocs.org/en/latest/).

The naive version serves as a basic example to get started on using smart contracts. It also showcases a typical issue with smart contracts - privacy. One player makes a choice (e.g. "rock") which is then written into the blockchain. This allows the second player to make a winning choice by observing the choice of the first player.

The advanced version splits the game into two phases: in the first phase the player is chosing not only rock paper or scissors but also a random string. The random strings have to be entered then in the reveal phase which allows for non-cheatable reaveling of the initial choice. If a player opts to not disclose their choice (because they know that they lost), the player that revealed first will be decleared the default winner after two minutes.
