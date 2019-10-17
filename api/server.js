const express = require("express");
const path = require("path");
const compression = require('compression');
const cors = require('cors');
const bodyParser = require('body-parser')

const routeLogin = require('./routes/login');

const app = express();
app.use(compression());

app.use(cors());
app.use(bodyParser.json());
app.use(
    bodyParser.urlencoded({
        extended: true
    })
);

routeLogin.setup(app);

process.on('uncaughtException', (ex) => {
    console.log("ex==", ex);
});

module.exports = app;