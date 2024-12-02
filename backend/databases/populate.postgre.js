import { sql } from '@vercel/postgres';

export async function populateDB() {
    try {
        await sql`
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                username VARCHAR(50) NOT NULL,
                email VARCHAR(100) NOT NULL UNIQUE,
                password TEXT NOT NULL
            );
        `;
        console.log('Users table created or already exists.');

        // Step 2: Insert the data into the `users` table
        const users = [
            {
                id: 1,
                username: 'k1',
                email: 'user1@example.com',
                password: '$2a$12$zPlq1NLDZmgofBpy6LwiB.2q5zSU5TGQdk3Fh3Ll.PFYc7mrQXaAa' // bcrypt hash for 'ti3a'
            }
        ];

        for (const user of users) {
            await sql`
                INSERT INTO users (id, username, email, password)
                VALUES (${user.id}, ${user.username}, ${user.email}, ${user.password})
                ON CONFLICT (id) DO NOTHING; -- Prevent duplicate insertions
            `;
        }

        console.log('User data inserted successfully.');
    } catch (error) {
        console.error('Error:', error);
    }
};
export async function getUsernameById(userId) {
  const result = await sql`

  SELECT username, email
      FROM users
      WHERE id = ${userId};
  `;

  if (result.rows.length > 0) {
    return result.rows[0].email; // Return the username
  } else {
    return 'No user found with the given ID.';
  }
}
export async function getUserByUserName(userName) {
  const result = await sql`
    SELECT * FROM users WHERE username = ${userName};
  `;
  return result['rows']; // Returns an array of all columns for the row(s) that match the id
}