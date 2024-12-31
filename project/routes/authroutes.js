const express = require('express');
const { registerUser, verifyOtpAndRegister , login  , resentOtp} = require('../controllers/authController');
const app = express();
const router = express.Router();

router.post('/register', registerUser);
router.post('/verify-otp', verifyOtpAndRegister);
router.post('/login',login)
router.post("/resentOtp" ,resentOtp)

module.exports = router;