import Mux from '@mux/mux-node';
import dotenv from 'dotenv';
import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

const app = express();

const corsOptions = {
    origin: 'http://127.0.0.1:5500', // Allow the frontend to make requests
    methods: ['GET', 'POST', 'DELETE'],
    allowedHeaders: ['Content-Type'],
  };
  
app.use(cors(corsOptions)); // Enable CORS with the options
  


dotenv.config();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const mux = new Mux({
  tokenId: process.env.MUX_TOKEN_ID,
  tokenSecret: process.env.MUX_TOKEN_SECRET
});

app.post('/streams', async (req, res) => {
  // const run = async () =>{
    try {
      const stream = await mux.video.liveStreams.create({
        playback_policy: ['public'],
        new_asset_settings: { playback_policy: ['public'] },
        })
        console.log(stream);
        res.status(200).json(stream); 
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error creating stream' });
    } 
   
  // };
})



app.listen(3000, () => {
  console.log('Server running on port 3000');
});