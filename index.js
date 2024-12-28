import dotenv from 'dotenv';
import express from 'express';
import streamRoutes from './stream-routes.js';
import cors from 'cors';
import http from 'http';

dotenv.config();

const app = express();
const server = http.createServer(app);

const PORT = process.env.PORT || 3000;

const corsOptions = {
  origin: ['http://127.0.0.1:3000', 'http://localhost:3000'],
  methods: ['GET', 'POST', 'DELETE', 'PATCH'],
  allowedHeaders: ['Content-Type']
};

app.use(cors(corsOptions));
app.use(express.json());
app.use('/api', streamRoutes);

console.log('Checking Mux credentials:', {
  tokenId: process.env.MUX_TOKEN_ID ? 'Present' : 'Missing',
  tokenSecret: process.env.MUX_TOKEN_SECRET ? 'Present' : 'Missing'
});

server.listen(PORT, () => {
  console.log(`API Server running on port ${PORT}`);
});