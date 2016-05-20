express = require('express');
Web3 = require('web3');
nodeUrl = "http://localhost:8545";
var contractAddress = 0;
var contractAbi = require('ABI.json');
web3 = new Web3(new Web3.providers.HttpProvider(nodeUrl));

var app = express();

app.get('/', function(req, res) {
    //res.send('Hello World!');
    var block = web3.eth.getBlockNumber();
    res.send('block=' + block);
});

app.get('/commit', function(

app.listen(8080);
