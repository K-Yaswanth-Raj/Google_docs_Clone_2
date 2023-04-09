const express = require('express');
const mongoose = require('mongoose');

const PORT = process.env.PORT | 3001;

const app = express();

const DB = 'mongodb+srv://yash:yash123@cluster0.nk12ari.mongodb.net/?retryWrites=true&w=majority';



mongoose.connect(DB).then(() => {
    console.log('Connection Successful');
}).catch((e) => {
    console.log('Error')
});

app.listen(PORT, '0.0.0.0', () => {
    console.log('Connected at port 3001');
});