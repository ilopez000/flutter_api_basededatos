const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'persona'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('Conectado a la base de datos MySQL');
});

app.get('/api/personas', (req, res) => {
  const sql = 'SELECT * FROM datos';
  db.query(sql, (err, result) => {
    if (err) {
      res.status(500).json({ error: 'Error al obtener los datos' });
    } else {
      res.json(result);
    }
  });
});

app.get('/api/personas/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'SELECT * FROM datos WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Error al obtener los datos' });
        } else {
            if (result.length > 0) {
                res.json(result[0]);
            } else {
                res.status(404).json({ error: 'No se encontró ninguna persona con ese ID' });
            }
        }
    });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en el puerto ${PORT}`);
});
