#!/bin/bash -xe
sudo apt-get update -y
sudo apt-get install -y nodejs npm postgresql-client
sudo npm install -g forever
git clone "https://github.com/kul-samples/sample-nodejs-postgres.git" /opt/app
cd /opt/app
npm install
export PGPASSWORD=
export DB_USER=
export DB_PWD=
export DB_URL=
psql -h $DB_URL -U $DB_USER --dbname $DB_NAME < createEmployeeTable.sql
forever start app.js
 