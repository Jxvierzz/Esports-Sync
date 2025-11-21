// server.js
const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;

// Configura tus tokens de Twitter API
const BEARER_TOKEN = 'AAAAAAAAAAAAAAAAAAAAALKh5QEAAAAAUPnLH8AwEDMpxcY4C%2BoiUPhPml8%3DdiQof9vTpqMu4PJ5eziW4AUT8u2OX5QH5iOqilA0u739MBnexq';

app.get('/tweets', async (req, res) => {
  try {
    const username = 'anonimotum'; // Cuenta oficial de LoL Esports
    const userResponse = await axios.get(`https://api.x.com/2/usage/tweets`, {
      headers: {
        'Authorization': `Bearer ${BEARER_TOKEN}`
      }
    });

    const userId = userResponse.data.data.id;

    const tweetsResponse = await axios.get(`https://api.x.com/2/usage/tweets`, {
      headers: {
        'Authorization': `Bearer ${BEARER_TOKEN}`
      },
      params: {
        max_results: 10, // Número de tweets a traer
        'tweet.fields': 'created_at,text' // Campos que quieres
      }
    });

    res.json(tweetsResponse.data);
  } catch (error) {
    res.status(500).send('Error fetching tweets');
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
