const pool = require('../db/index');


const submitForm = async (req, res) => {
    if (!req.user || !req.user.id) {

        console.log("unauthorized")
        return res.status(401).json({ status: "error", error: "Unauthorized" });
    }
  const {
    nom,
    prenom,
    email,
    phonenumber,
    address,
    wilaya,
    cout_minimale,
    sexe,
    service,
    description,
  } = req.body;

  try {
  
    await pool.query(
        `UPDATE profilsartisans
         SET nom = $1, prenom = $2, email = $3, phone_number = $4, address = $5, wilaya = $6, prix = $7, sexe = $8, service_id = (SELECT id FROM services WHERE nom = $9), description = $10
         WHERE id = $11`,
        [nom, prenom, email, phonenumber, address, wilaya, cout_minimale, sexe, service, description, req.user.id]
      );

    res.status(200).json({ message: 'Form submitted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred while submitting the form' });
  }
};

module.exports = { submitForm };