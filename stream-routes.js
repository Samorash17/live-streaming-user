import express from 'express';
import Mux from '@mux/mux-node';
import dotenv from 'dotenv';

dotenv.config();

const router = express.Router();

// Fix the Mux initialization
const muxClient = new Mux({
  tokenId: process.env.MUX_TOKEN_ID,
  tokenSecret: process.env.MUX_TOKEN_SECRET
});



// Create a new live stream
router.post('/streams', async (req, res) => {
  console.log("Attempting to create stream...");
  try {
    const stream = await muxClient.video.liveStreams.create({
      playback_policy: ['public'],
      new_asset_settings: { playback_policy: ['public'] }
    });

    console.log("Stream created successfully:", stream);
    res.status(200).json({
      streamKey: stream.stream_key,
      playbackId: stream.playback_ids[0].id,
      status: stream.status,
      streamId: stream.id
    });
  } catch (error) {
    // More detailed error logging
    console.error('Error creating stream. Full error:', error);
    console.error('Error message:', error.message);
    console.error('Error stack:', error.stack);
    res.status(500).json({ 
      error: 'Failed to create stream',
      details: error.message  // Adding error details to the response
    });
  }
});

// Get stream details
router.get('/streams/:streamId', async (req, res) => {
  try {
    const stream = await muxClient.video.liveStreams.get(req.params);
    
    res.status(200).json({
      streamKey: stream.stream_key,
      playbackId: stream.playback_ids[0].id,
      status: stream.status,
      streamId: stream.id,
      isActive: stream.status === 'active'
    });
  } catch (error) {
    console.error('Error getting stream:', error);
    res.status(500).json({ error: 'Failed to get stream details' });
  }
});

// Delete a stream
router.delete('/streams/:streamId', async (req, res) => {
  try {
    await Video.LiveStreams.delete(req.params.streamId); 
    res.json({ message: 'Stream deleted successfully' });
  } catch (error) {
    console.error('Error deleting stream:', error);
    res.status(500).json({ error: 'Failed to delete stream' });
  }
});

// Webhook handler for stream status updates
router.post('/webhooks/mux', async (req, res) => {
  const event = req.body;
  
  try {
    switch (event.type) {
      case 'video.live_stream.active':
        // Stream has started
        // Update your database/notify users
        break;
        
      case 'video.live_stream.idle':
        // Stream has ended
        // Update your database/notify users
        break;
        
      case 'video.asset.ready':
        // VOD asset is ready (if you're recording streams)
        break;
    }
    
    res.json({ message: 'Webhook processed' });
  } catch (error) {
    console.error('Webhook processing error:', error);
    res.status(500).json({ error: 'Webhook processing failed' });
  }
});


export default router; 
