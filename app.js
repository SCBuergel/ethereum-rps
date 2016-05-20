express = require('express');
Web3 = require('web3');
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var app = express();

app.get('/', function(req, res) {
    //res.send('Hello World!');
    var block = web3.eth.getBlockNumber(function(err, res2) {
	res.send(err + ' ' + res2);});
//    res.send('block=' + block);
});

app.listen(8080);
