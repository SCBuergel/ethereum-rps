/*
simple rock paper scissors game on ethereum
version 1:
player 1 and player 2 pay 5 ether to register, if there are already more players registered this fails
player 1 and 2 both submit a string that is stored and evaluated once the second player has submitted

version 2:
players submit hashed version of their string

version 3:
players submit hashed version of their string and a random string

version 4:
after N blocks the players can request withdrawal of their cash

version 5:
game operator charges 1% per game

version 6:
game operator can induce suicide of the contract
*/

contract rps
{
    mapping (string => mapping(string => int)) payoffMatrix;
    address player1;
    address player2;
    string public player1Choice;
    string public player2Choice;

    modifier notRegisteredYet()
    {
        if (msg.sender == player1 || msg.sender == player2)
            throw;
        else
            _
    }
    
    modifier sentEnoughCash(uint amount)
    {
        if (msg.value < amount)
            throw;
        else
            _
    }
    
    function rps() 
    {   // constructor
        payoffMatrix["rock"]["rock"] = 0;
        payoffMatrix["rock"]["paper"] = 2;
        payoffMatrix["rock"]["scissors"] = 1;
        payoffMatrix["paper"]["rock"] = 1;
        payoffMatrix["paper"]["paper"] = 0;
        payoffMatrix["paper"]["scissors"] = 2;
        payoffMatrix["scissors"]["rock"] = 2;
        payoffMatrix["scissors"]["paper"] = 1;
        payoffMatrix["scissors"]["scissors"] = 0;
    }
    
    function checkBothNotNull() constant returns (bool x)
    {
        return (bytes(player1Choice).length == 0 && bytes(player2Choice).length == 0);
    }
    
    function getWinner() constant returns (int x)
    {
        return payoffMatrix[player1Choice][player2Choice];
    }
    
    function play(string choice) returns (int w)
    {
        if (msg.sender == player1)
            player1Choice = choice;
        else if (msg.sender == player2)
            player2Choice = choice;
        if (bytes(player1Choice).length != 0 && bytes(player2Choice).length != 0)
        {
            int winner = payoffMatrix[player1Choice][player2Choice];
            if (winner == 1)
                player1.send(this.balance);
            else if (winner == 2)
                player2.send(this.balance);
            else
            {
                player1.send(this.balance/2);
                player2.send(this.balance/2);
            }
            // TODO: transfer funds to winner
             
            // unregister players and choices
            player1Choice = "";
            player2Choice = "";
            player1 = 0;
            player2 = 0;
            return winner;
        }
        else 
            return -1;
    }
    
    function getMyBalance () constant returns (uint amount)
    {
        return msg.sender.balance;
    }
    
    function getContractBalance () constant returns (uint amount)
    {
        return this.balance;
    }
    
    function register()
        sentEnoughCash(5)
        notRegisteredYet()
    {
        if (player1 == 0)
            player1 = msg.sender;
        else if (player2 == 0)
            player2 = msg.sender;
    }
    
    function AmIPlayer1() constant returns (bool x)
    {
        return msg.sender == player1;
    }
    
    function AmIPlayer2() constant returns (bool x)
    {
        return msg.sender == player2;
    }
    
/*
    address owner;
    
    modifier ownerOnly () 
    {
        if (msg.sender != owner)
            throw;
        else
            _
    }
    
    address[] players;
    
    function CheckOwner() constant returns (bool x) 
    {
        return msg.sender == owner;
    }
    
    
    function RegisterPlayer(address newPlayer) 
        ownerOnly
    {
        players.push(newPlayer);
    }
*/

}