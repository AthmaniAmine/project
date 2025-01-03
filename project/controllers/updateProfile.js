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

const updateProfilePicture= async (req , res)=>{
try{
  if (!req.user || !req.user.id) {

    console.log("unauthorized")
    return res.status(401).json({ status: "error", error: "Unauthorized" });
}

  const file = req.file 
  const profilePicturePath = `${req.protocol}://${req.get('host')}/uploads/${file.filename }`
  const query = 'UPDATE profilsartisans SET photo_de_profil = ? WHERE id = ?';
  const query2 = 'UPDATE utilisateurs SET photo_de_profil = ? WHERE id = ?';

  if (req.user.type_utilisateur == "artisan"){
    await db.query(query, [profilePicturePath, req.user.id]);
    await db.query(query2, [profilePicturePath, req.user.id])
  }else{
    await db.query(query2, [profilePicturePath, req.user.id])
  }
  res.status(200).json({ message: 'Profile picture updated successfully', profilePicturePath });
}catch(err){
  console.error('Error updating profile picture:', error);
        res.status(500).json({ message: 'Failed to update profile picture' });
}
}




module.exports = { submitForm , updateProfilePicture };