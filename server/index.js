const express = require('express');
const mongoose = require('mongoose');
const router = require('./routes/auth.js')
const app  = express();
const PORT = 3000;
const DB = "mongodb+srv://tayyabltd007:Tayyabawan933@cluster0.c5myzm4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
app.use(express.json());
app.use(router);

mongoose.connect(DB).then(()=>{
    console.log('Connected to MongoDb');

}).catch(()=>{
    
})

app.listen(PORT,'0.0.0.0',()=>{
    console.log(`Server is running on port,${PORT}`);
})  
