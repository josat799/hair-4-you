const express = require('express')

module.exports = {
    getUsers: (req, res) => {
        const users = {
            '1': {'name': 'Josef Atoui'},
            '2': {'name': 'Test Användare'},
        }

        return res.status(200).json({ users: users })
    }
}