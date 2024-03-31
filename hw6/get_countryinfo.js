const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const config = require('../config.json');
const q = 'SELECT * FROM country ORDER BY country_name'

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

        var res = '<html>\n<body>\n<form method="post" action="/country">\n\n <select name = "CountryChoice">\n';

        for (const r of result) {
            res += '<option>' + r['country_name'] + '</option>\n'
        }

        res += '</select>\n<input type = "submit" value = "Execute Query"/>\n</form>\n</body>\n</html>';
        response.send(res);

    });
    cn.end();
});

app.post('/country', function (request, response) {
    const selectedCountry = request.body.CountryChoice;
    const qCountryInfo = 'SELECT * FROM country WHERE country_name = ?';

    const cn = mysql.createConnection(config);
    cn.connect();

    cn.query(qCountryInfo, [selectedCountry], function(err, result, fields) {
        if (err) {console.log('Error: ', err)};

        if (result.length > 0) {
            const countryInfo = result[0];
            var res = '<html>\n<body>\n<h2>Country Information</h2>\n';
            res += `<p>Country Name: ${countryInfo.country_name}</p>\n`;
            res += `<p>Country Code: ${countryInfo.country_code}</p>\n`;
            res += `<p>GDP: ${countryInfo.gdp}</p>\n`;
            res += `<p>Inflation: ${countryInfo.inflation}</p>\n`;
            res += '</body>\n</html>';
            response.send(res);        
        } else {
            response.send('Country not found');
        }
    });
    cn.end();
});
