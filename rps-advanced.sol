contract rpsAdvanced
{
    mapping (string => mapping(string => int)) payoffMatrix;
    address player1;
    address player2;
    bytes32 player1ChoiceHash;
    bytes32 player2ChoiceHash;
    string public player1Choice;
    string public player2Choice;
    uint firstRevealTime;

    modifier notRegisteredYet()
    {
        if (msg.sender == player1 || msg.sender == player2)
            throw;
        else
            _
    }

    modifier isRegistered()
    {
        if (msg.sender != player1 && msg.sender != player2)
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
    
    modifier validChoice(string choice)
    {
        // hack until we can use StringUtils.equal
        if (sha3(choice) != sha3("rock") && sha3(choice) != sha3("paper") && sha3(choice) != sha3("scissors"))
            throw;
        else
            _
    }
    
    function rpsAdvanced() 
    {   // constructor (spoiler alert: rename this if you rename the contract!)
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
    
    function register()
        sentEnoughCash(5)
        notRegisteredYet
    {
        if (player1 == 0)
            player1 = msg.sender;
        else if (player2 == 0)
            player2 = msg.sender;
    }

    function play(string choice, string randStr) 
        isRegistered
        validChoice(choice)
    {
        if (msg.sender == player1)
            player1ChoiceHash = sha3(sha3(choice) ^ sha3(randStr));
        else if (msg.sender == player2)
            player2ChoiceHash = sha3(sha3(choice) ^ sha3(randStr));
    }
    
    function reveal(string choice, string randStr)
        isRegistered
        validChoice(choice)
    {
        // second player has 120 seconds after first player revealed
        if (bytes(player1Choice).length == 0 && bytes(player2Choice).length == 0)
            firstRevealTime == now;

        // if hashed choice + randStr is matching the initial one, choice is stored
        if (msg.sender == player1 && sha3(sha3(choice) ^ sha3(randStr)) == player1ChoiceHash)
            player1Choice = choice;
        if (msg.sender == player2 && sha3(sha3(choice) ^ sha3(randStr)) == player2ChoiceHash)
            player2Choice = choice;
    }
    
    function checkWinner()
    {
        if (bytes(player1Choice).length != 0 && bytes(player2Choice).length != 0)
        {
            // if both revealed, obtain winner in usual way
            int winner = payoffMatrix[player1Choice][player2Choice];
            if (winner == 1)
                player1.send(this.balance);
            else if (winner == 2)
                player2.send(this.balance);
            else
            {
                player1.send(this.balance/2);
                player2.send(this.balance);
            }

            // unregister players and choices
            player1Choice = "";
            player2Choice = "";
            player1 = 0;
            player2 = 0;
        }
        else if (now > firstRevealTime + 120)
        {
            // if only one player revealed and time > start + timeout, winner is the one who revealed first
            if (bytes(player1Choice).length != 0)
                player1.send(this.balance);
            else if (bytes(player2Choice).length != 0)
                player2.send(this.balance);
        }
        
    }
    
    // HELPER FUNCTIONS
    function getMyBalance () constant returns (uint amount)
    {
        return msg.sender.balance;
    }
    
    function getContractBalance () constant returns (uint amount)
    {
        return this.balance;
    }
    
    function AmIPlayer1() constant returns (bool x)
    {
        return msg.sender == player1;
    }
    
    function AmIPlayer2() constant returns (bool x)
    {
        return msg.sender == player2;
    }
    
    // \HELPER FUNCTIONS
}
