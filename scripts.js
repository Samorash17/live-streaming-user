const MUX_TOKEN_ID = 'YOUR_TOKEN_ID';
const MUX_TOKEN_SECRET = 'YOUR_TOKEN_SECRET';
const API_URL = 'http://localhost:3000';

const webcamElement = document.getElementById('webcam');
const startStreamButton = document.getElementById('startStream');
const stopStreamButton = document.getElementById('stopStream');
const streamDetails = document.getElementById('streamDetails');
const streamKeyElement = document.getElementById('streamKey');
const playbackUrlElement = document.getElementById('playbackUrl');

let mediaStream = null;
let mediaRecorder;
let streamKey;

// Get access to the webcam
async function startWebcam() {
    try {
        mediaStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
        webcamElement.srcObject = mediaStream;
    } catch (error) {
        console.error('Error accessing webcam:', error);
        alert('Unable to access webcam. Please check your permissions.');
    }
}

// Start streaming to Mux
async function startStreaming() {
    try {
        // Get webcam stream
        const mediaStream = await navigator.mediaDevices.getUserMedia({ 
            video: true,
            audio: true 
        });
        
        // Show preview
        const videoPreview = document.getElementById('preview');
        videoPreview.srcObject = mediaStream;
        
        // Create stream on MUX
        const response = await fetch(`${API_URL}/streams`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                playback_policy: ['public']
            })
        });

        if (!response.ok) {
            throw new Error('Failed to create stream');
        }

        const data = await response.json();
        streamKey = data.stream_key;
        const playbackId = data.playback_id;

        // Display stream info
        document.getElementById('streamKey').textContent = streamKey;
        document.getElementById('playbackId').textContent = playbackId;
        
        // Generate viewer URL
        const viewerUrl = `${window.location.origin}/view/${playbackId}`;
        document.getElementById('viewerLink').href = viewerUrl;
        document.getElementById('viewerLink').textContent = viewerUrl;

        // Start broadcasting using WebRTC
        startBroadcast(mediaStream, streamKey);

    } catch (error) {
        console.error('Error:', error);
        alert('Failed to start stream: ' + error.message);
    }
}

async function startBroadcast(mediaStream, streamKey) {
    const rtmpUrl = `rtmp://global-live.mux.com/app/${streamKey}`;
    
    // Using media-stream-broadcaster package
    const broadcaster = new MediaStreamBroadcaster({
        mediaStream,
        rtmpUrl,
        width: 1280,
        height: 720,
        videoBitrate: 2500,
        audioBitrate: 128
    });

    await broadcaster.start();
    console.log('Broadcasting started');
}

// Stop streaming
function stopStreaming() {
    if (mediaRecorder) {
        mediaRecorder.stop();
    }
    const tracks = videoPreview.srcObject.getTracks();
    tracks.forEach(track => track.stop());
}

// Stop the webcam stream
function stopWebcam() {
    if (mediaStream) {
        mediaStream.getTracks().forEach((track) => track.stop());
        mediaStream = null;
    }
}

// Add event listeners
document.getElementById('startStream').addEventListener('click', startStreaming);
document.getElementById('stopStream').addEventListener('click', stopStreaming);

// Initialize webcam on page load
startWebcam();
