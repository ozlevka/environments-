const express = require('express');


const app = express();

app.use(express.json());







const { APP_PORT = 8080 } = process.env

app.listen(APP_PORT, () => {
    console.log(`App start and listen to port ${APP_PORT}`);
});