const pool = require('../db/index');

// Function to copy data from utilisateurs to profilsartisans
const copyUserToArtisan = async (req, res) => {
    if (!req.user || !req.user.id) {

        console.log("unauthorized")
        return res.status(401).json({ status: "error", error: "Unauthorized" });
    }
    

  

  

  try {
    // Fetch data from the utilisateurs table
    const userData = await pool.query(
      'SELECT nom, prenom, email, id FROM utilisateurs WHERE id = $1',
      [req.user.id]
    );

    if (userData.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Destructure the fetched data
    const { nom, prenom, email, id } = userData.rows[0];

    console.log('Fetched user data:', { nom, prenom, email, id }); // Debugging log

    // Insert data into the profilsartisans table
    await pool.query(
      `INSERT INTO profilsartisans (nom, prenom, email, id)
       VALUES ($1, $2, $3, $4)`,
      [nom, prenom, email, id]
    );

    res.status(200).json({ message: 'Data copied successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred while copying data' });
  }
};

module.exports = { copyUserToArtisan };