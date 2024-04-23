const express = require("express");
require("express-async-errors");
const cors = require("cors");
const morgan = require("morgan");
const cookieParser = require("cookie-parser");
const routes = require("./routes");
const helmet = require("helmet");
const compression = require("compression");
const unknownEndpoint = require("./middleware/unKnownEndpoint");
const { handleError } = require("./helpers/error");

const app = express();

// app.set("trust proxy", 1);
const whitelist = ["https://d6670544.cloudfront.localhost.localstack.cloud", "http://localhost:3000", process.env.CLIENT_URL]
const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  },
  credentials: true,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
}
app.all('*', function (req, res, next) {
  res.header('Access-Control-Allow-Origin', "https://d6670544.cloudfront.localhost.localstack.cloud");
  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  if ('OPTIONS' == req.method) {
    res.sendStatus(200);
  } else {
    next();
  }
});
app.use(cors(corsOptions));
app.use(express.json());
app.use(morgan("dev"));
app.use(compression());
app.use(helmet());
app.use(cookieParser());

app.use("/api", routes);

app.get("/", (req, res) =>
  res.send("<h1 style='text-align: center'>E-COMMERCE API</h1>")
);
app.use(unknownEndpoint);
app.use(handleError);

module.exports = app;
