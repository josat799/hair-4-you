const express = require('express')
const userModel = require('../models/user.model')

module.exports = {
    getUsers: (req, res) => {
        const users = [new userModel.User('Josef Atoui', '0707769116', null ,'josef.atoui@live.se', Date(1997, 05, 30), null)]

        return res.status(200).json({ users: users })
    }
}