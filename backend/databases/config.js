import { Sequelize } from "sequelize";

const db = new Sequelize('njczidlb_hairmate', 'njczidlb_nioke', 'nioke8090', {
  host: '109.110.188.74',
  dialect: /* one of 'mysql' | 'postgres' | 'sqlite' | 'mariadb' | 'mssql' | 'db2' | 'snowflake' | 'oracle' */ 'mysql'
});
export default db;
// import mysql from "mysql2";
// const dbPool = mysql.createPool({
//   host: "109.110.188.74",
//   user: "njczidlb_nioke",
//   password: "nioke8090",
//   database: "njczidlb_hairmate",
// }).promise();

// export default dbPool;