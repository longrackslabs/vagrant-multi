var express = require('express');
var mysql = require('mysql');
var app = express();

// Demo only - don't store real creds in the app file
var connection = mysql.createConnection({
  host		: 'localhost',
  user		: 'root',
  password	: 'foo',
});

app.get('/', function(req, res) {
  var now = new Date();

  res.writeHead(200, {
    'Transfer-Encoding': 'chunked',
    'Content-Type': 'text/plain; charset="utf-8'
  });

  res.write("Hello World! " + now.toDateString() + ":" + now.toTimeString());
  res.write("\n\nNow connecting to mysql...");

  connection.connect(function(err) {
    if(err) {
      res.write("\n\nConnection failed\n");
    }
    else {
      res.write("\n\nConnection successful!\n");
    }
    res.end();
  })
});

app.listen(3000);
console.log('Listening on port 3000');

