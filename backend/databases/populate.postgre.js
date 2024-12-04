import dotenv from 'dotenv';
// import dbPool from './config.js';
import db from './config.js';
// dotenv.config({ path: '.env.development.local' });
// import dbPool from './config';

// import mysql from "mysql2";
// const dbPool = mysql.createPool({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USERNAME,
//   password: process.env.DB_PASSWORD,
//   database: process.env.DB_NAME,
// }).promise();

// module.exports = dbPool.promise();
import { users } from './data.js';

export async function setTables(){
  await db.query(`
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(50) NOT NULL,
      email VARCHAR(100) NOT NULL UNIQUE,
      password TEXT NOT NULL
    );
    
    CREATE TABLE IF NOT EXISTS scan_history (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        face_shape VARCHAR(50) NOT NULL,
        scan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
    
    CREATE TABLE IF NOT EXISTS hair_styles (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description TEXT NOT NULL,
        suitable_for_face_shape VARCHAR(50) NOT NULL
    );
    
    CREATE TABLE IF NOT EXISTS recommendations (
        id INT AUTO_INCREMENT PRIMARY KEY,
        scan_id INT NOT NULL,
        hairstyle_id INT NOT NULL,
        rank INT NOT NULL,
        FOREIGN KEY (scan_id) REFERENCES scan_history(id) ON DELETE CASCADE,
        FOREIGN KEY (hairstyle_id) REFERENCES hair_styles(id) ON DELETE CASCADE
    );
    
    CREATE TABLE IF NOT EXISTS barber_shops (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        location TEXT NOT NULL,
        contact_info VARCHAR(100)
    );
    
    CREATE TABLE IF NOT EXISTS barber_shop_images (
        id INT AUTO_INCREMENT PRIMARY KEY,
        barber_shop_id INT NOT NULL,
        image_url TEXT NOT NULL,
        FOREIGN KEY (barber_shop_id) REFERENCES barber_shops(id) ON DELETE CASCADE
    );
    
    CREATE TABLE IF NOT EXISTS haircut_images (
        id INT AUTO_INCREMENT PRIMARY KEY,
        hairstyle_id INT NOT NULL,
        image_url TEXT NOT NULL,
        FOREIGN KEY (hairstyle_id) REFERENCES hair_styles(id) ON DELETE CASCADE
    );
    
    CREATE TABLE IF NOT EXISTS products (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        category VARCHAR(50),
        description TEXT
    );
    
    CREATE TABLE IF NOT EXISTS product_images (
        id INT AUTO_INCREMENT PRIMARY KEY,
        product_id INT NOT NULL,
        image_url TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
    );  
  `);
  // await dbPool.execute(query); // Eksekusi query
  console.log('Users table created or already exists.');
}

export async function populateDB() {
    try {
        // Step 2: Insert the data into the `users` table
        // const users = [
        //     {
        //         id: 1,
        //         username: 'k1',
        //         email: 'user1@example.com',
        //         password: '$2a$12$zPlq1NLDZmgofBpy6LwiB.2q5zSU5TGQdk3Fh3Ll.PFYc7mrQXaAa' // bcrypt hash for 'ti3a'
        //     }
        // ];
        // let userInsert = ``;
        for (const user of users) {
          await db.query(`
          INSERT INTO users (id, username, email, password)
          VALUES (${user.id}, '${user.username}', '${user.email}', '${user.password}')
          ON DUPLICATE KEY UPDATE id=id; -- Prevent duplicate insertions
          `);
          // await dbPool.execute(userInsert);
        }

        console.log('User data inserted successfully.');
    } catch (error) {
        console.error('Error:', error);
    }
};
export async function getUsernameById(userId) {
}
export async function getUserByUserName(userName) {
  const result = await sql`
    SELECT * FROM users WHERE username = ${userName};
  `;
  return result['rows']; // Returns an array of all columns for the row(s) that match the id
}