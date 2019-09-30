const express = require('express');
const router = express.Router();
const userController = require('./user.controller');

router.get('/', userController.getUsers);
router.get('/:id', userController.getUser);
router.put('/:id', userController.updateUser);
router.post('/add', userController.createUser);

module.exports = router;
