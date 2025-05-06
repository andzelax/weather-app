const express = require('express');
const axios = require('axios');//do zapytan HTTP
const dotenv = require('dotenv');//do zmiennych srodowiskowych
const path = require('path');
dotenv.config();//wczytuje .env
const app = express();
const PORT = process.env.PORT || 3000;


// informacja w konsoli na starcie kontenera
console.log(`Data uruchomienia: ${new Date().toISOString()}`);
console.log("Autor: Andżelika Gawinkowska");
console.log(`Aplikacja nasłuchuje na porcie: ${PORT}`);

app.use(express.static('public'));
app.use(express.json());

// Endpoint do pobrania pogody
app.post('/weather', async (req, res) => {
  const { country, city } = req.body;

  try {
    const apiKey = process.env.OPENWEATHER_API_KEY;
    const weatherUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city},${country}&units=metric&appid=${apiKey}&lang=pl`;
    const response = await axios.get(weatherUrl);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: "Błąd podczas pobierania pogody." });
  }
});

app.listen(PORT);
