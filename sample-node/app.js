var express = require('express');
var app = express();

app.get('/', function(req, res) {
  var now = new Date();

  res.writeHead(200, {
    'Transfer-Encoding': 'chunked',
    'Content-Type': 'text/plain; charset="utf-8'
  });

  res.write("Node: Hello World! " + now.toDateString() + ":" + now.toTimeString());
  res.end();
});

app.listen(3000);
console.log('Listening on port 3000');

