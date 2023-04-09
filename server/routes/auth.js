const express = require('express');
const User = require('../models/user');

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

        res.json({ user });

    } catch (e) {

    }
});

authRouter.get('/api/get', (req, res) => {

});

module.exports = authRouter;