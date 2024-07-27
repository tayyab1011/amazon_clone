const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const router = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

router.post('/api/signUp', async (req, res) => {
    try {
        const { name, email, password,} = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        };
        
        const hashedPassword = await bcrypt.hash(password, 8);
        let user = User({
            name,
            email,
            password: hashedPassword
        });
        user = await user.save();
        res.status(201).json(user);
    } catch (e) {
        res.status(500).json({ message: e.message });
    }
});
//Signin route
router.post('/api/signIn',async(req,res) => {
    try{
        const {email,password} = req.body;
        const user =await User.findOne({email});
    if(!user){
        return res.status(400).json({message: 'User not found'});
    }
    const isMatch = await bcrypt.compare(password,user.password);
    if(!isMatch){
        return res.status(400).json({message: 'Incorrect password'})   ; 
    }
    const token = jwt.sign({id: user._id},'secret123');
    res.json({token, ...user._doc});
    }
    catch(e){
        res.status(500).json({message: e.message});
   }
});
//get data api
router.post("/tokenIsValid", async (req, res) => {
    try{
        const token = req.header("x-auth-token");
        if(!token) return res.json(false);
        const verified = jwt.verify(token, 'secret123');
        if(!verified) return res.json(false);
        const user = User.findByID(verified.id);
        if(!user) return res.json(false);
        return res.json(true);
    }
    catch(e){
        res.status(401).json({error: e.message});
    }
});
//get user data
router.get('/get',auth,(req,res)=>{
    const user = User.findByID(req.user);
    res.json({...user._doc,token:req.token});

})

module.exports = router;