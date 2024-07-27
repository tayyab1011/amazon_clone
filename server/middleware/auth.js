const jwt = require('jsonwebtoken');

const auth = async (req,res,next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token){
            res.status(401).json({message:"No auth token, access denied"});
        }
        const verified = jwt.verify(token,'secret123');
        if(!verified){
            res.status(401).json({message:"Token verification failed"});
        }
        req.user = verified.id;
        req.token = token;
        next();

    }catch(e){
        res.status(500).json({message: e.message});

    }

}
module.exports = auth;