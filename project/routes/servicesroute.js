const express = require('express');
const router = express.Router();
const { getArtisansByServiceId , searchServices } = require('../controllers/services');


router.get('/service/:service_id', getArtisansByServiceId);
router.get('/search', searchServices);
module.exports = router;