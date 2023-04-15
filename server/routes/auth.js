const express = require('express');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email } = req.body;

        let user = await User.findOne({ email: email });

        if (!user) {
            user = new User({
                email: email,
                name: name,
            });
            user = await user.save();
        }
        const token = jwt.sign({id:user._id},"passwordkey");

        res.json({ user,token });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.get('/',auth,async(req,res) => {
    const user = await User.findById(req.user);
    const token = req.token;
    res.json({user,token });
});

module.exports = authRouter;