var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
var app = express();

const Pool = require('pg-pool');
const url = require('url');

app.use(bodyParser.json());
app.set('port', process.env.PORT || 8080);
app.use(cors()); // CORS (Cross-Origin Resource Sharing) headers to support Cross-site HTTP requests
app.use(express.static("dist")); // Our Ionic app build is in the www folder (kept up-to-date by the Ionic CLI using 'ionic serve')

var DATABASE_URL = process.env.DATABASE_URL
  || 'postgres://developer:dev@localhost:5432/chrono_dev_db';
  //|| 'postgres://mfetlemxfcdrae:70a9a4de8c3c7a729b707e5c86952dda6c123b4eb54236998cd5b4b96ed1dd8d@ec2-23-21-85-76.compute-1.amazonaws.com:5432/d4vuce5q4o0f0i';

console.log(DATABASE_URL);

const params = url.parse(DATABASE_URL);
const auth = params.auth.split(':');

var fromBase = "nodata";

const config = {
  user: auth[0],
  password: auth[1],
  host: params.hostname,
  port: params.port,
  database: params.pathname.split('/')[1],
  //ssl: true
};

const createTableSql = 'CREATE TABLE IF NOT EXISTS facts (description varchar(255), fact_type_id integer NOT NULL, fact_id SERIAL)';

const pool = new Pool(config);
pool.query(createTableSql);

console.log("Database connection ready");

app.get('/api/facts', (req, res) => {
  pool.query('SELECT * FROM facts', function (err, results){
        if (err){
          res.status(500).json({"error": err.message});
          console.log(err.message);
        }
        else{
          res.json(results.rows);
        }

        return res;
      });
});

// POST: create a new todo
app.post("/api/facts", function(req, res) {
  //var facts = pool.query('INSERT INTO facts (description, fact_type_id) VALUES ($1, 1)', [req.body.description]);

  pool.query('INSERT INTO facts (description, fact_type_id) VALUES ($1, 1) RETURNING fact_id', [req.body.description], function (err, results){
        if (err){
          res.status(500).json({"error": err.message});
          console.log(err.message);
        }
        else{
          res.json(results.rows[0].fact_id);
        }

        return res;
      });
});

// Initialize the app.
app.listen(app.get('port'), function () {
  console.log("listen on port", app.get('port'));
});
