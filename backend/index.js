const express = require('express')
const userRoute = require('./routes/users')

const app = express()

app.use('/users', userRoute)
app.use(express.urlencoded({ extended: true }))
app.use(express.json())

module.exports = app