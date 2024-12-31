const express = require('express');
const router = express.Router();
const { submitForm } = require('../controllers/updateProfile');
const loggedin = require('../controllers/loggedin')
// POST /submit-form
router.post('/updateProfile',loggedin, submitForm);

module.exports = router;