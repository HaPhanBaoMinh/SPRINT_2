require("dotenv").config();
const { Pool } = require("pg");

const deployEnvironment = process.env.DEPLOY_ENVIRONMENT;
const database =
  process.env.NODE_ENV === "test"
    ? process.env.POSTGRES_DB_TEST
    : process.env.POSTGRES_DB;

const connectionString = `postgresql://${process.env.POSTGRES_USER}:${process.env.POSTGRES_PASSWORD}@${process.env.POSTGRES_HOST}:${process.env.POSTGRES_PORT}/${database}`;
const pool = new Pool({
  connectionString,
  /*
    SSL is not supported in development
    */
  ssl: deployEnvironment === "AWS" ? { rejectUnauthorized: false } : false,
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  end: () => pool.end(),
};
