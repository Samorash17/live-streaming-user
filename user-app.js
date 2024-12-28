import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import streamRoutes from './routes/stream-routes';

const app = express();

app.use(express.json());
app.use('/api/', streamRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 