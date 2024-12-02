import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js'; // Importing routes
// import { dotenv } from 'dotenv';
import { populateDB, getUsernameById, getUserByUserName } from './databases/populate.postgre.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Allow specific origin
const allowedOrigins = [
  'http://localhost:', // Untuk web dari localhost
  'http://http://10.0.2.2:', // Ganti dengan IP komputer host Anda
  'http://http://192',
  'http://http://196',
];
app.use(cors({
  origin: /* '*', */ (origin, callback) => {  
    if ( !origin || allowedOrigins.some(allowed_origin => origin.startsWith(allowed_origin)) ){ 
      callback(null, true); 
    } else callback( new Error('Not allowed by CORS') );// Tolak origin lain
  },  
  methods: ['GET', 'POST'],   // Allowed HTTP methods
  credentials: true           // Allow cookies and credentials
}));
app.use(bodyParser.json()); // Middleware to parse JSON requests

app.get('/', (req, res) => {
  res.send('Welcome to the API!');
});
app.use('/auth', authRoutes); // Use authentication routes
app.get('/populate', async (req, res) => {
  await populateDB(); // Call the function to populate the database
  res.send('Database populated!');
});
app.get('/user/:id', async (req, res, next) => {
  const userId = parseInt(req.params.id, 10);
  const username = await getUsernameById(userId); // If any error occurs, Express will handle it
  const userData = await getUserByUserName(username);
  res.send(`${username} and ${userData}`);
});
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});