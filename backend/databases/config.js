import { Sequelize } from "sequelize";

const db = new Sequelize('njczidlb_hairmate', 'njczidlb_nioke', 'nioke8090', {
  host: '109.110.188.74',
  dialect: /* one of 'mysql' | 'postgres' | 'sqlite' | 'mariadb' | 'mssql' | 'db2' | 'snowflake' | 'oracle' */ 'mysql'
});
export default db;