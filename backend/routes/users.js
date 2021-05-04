const express = require('express')
const router = express.Router()

const usersService = require('../services/user.service')

router.get('/', usersService.getUsers)

module.exports = router