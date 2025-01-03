const express = require('express');
const router = express.Router();
const { submitForm , updateProfilePicture } = require('../controllers/updateProfile');
const loggedin = require('../controllers/loggedin')
// POST /submit-form
router.post('/updateProfile',loggedin, submitForm);
router.post('/updateProfilePicture',loggedin, updateProfilePicture);
module.exports = router;