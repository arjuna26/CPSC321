const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const config = require('../config.json');
const q = 'SELECT * FROM pet ORDER BY type';

var app = express();
app.use(express.urlencoded({extended : false}));
app.use(express.json());
app.listen(3000);

// serve the form
app.get('/', function(request, response) {
    const cn = mysql.createConnection(config);
    cn.connect();

    cn.query(q, function(err, result, fields) {
        if (err) {console.log('Error: ', err)};

        var res = '<html>\n<body>\n<form>\n <select name = "PetTypeChoice">\n';

        for (const r of result) { 
            res += '<option>' + r['type'] + '</option>\n'
        }

        res += '</select>\n<input type = "submit" value = "Execute Query"/>\n</form>\n</body>\n</html>';
        response.send(res);
    });
    cn.end();
});