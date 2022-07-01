#!/bin/bash

# Exit when any command fails
set -e

# Variables
CSV_FILE="10M_records.csv"
DATABASE_NAME="curt"
TABLE_NAME="my_table"

# Ensure psql is installed and working
echo "Verifying psql installation"
psql --version

# Create the database
echo "Creating database=$DATABASE_NAME if it doesn't already exist"
psql -c "CREATE DATABASE $DATABASE_NAME;" postgres || true

# Create the table in the database
echo "Creating table=$TABLE_NAME in database=$DATABASE_NAME if it doesn't already exist"
psql -c "CREATE TABLE IF NOT EXISTS $TABLE_NAME (column_1 varchar, column_2 varchar, column_3 varchar, column_4 double precision, column_5 double precision, column_6 double precision);" $DATABASE_NAME

# Ensure table is empty
echo "Deleting existing data from table=$TABLE_NAME in database=$DATABASE_NAME"
psql -c "TRUNCATE $TABLE_NAME;" $DATABASE_NAME

# Bulk load the data from the csv into the table
echo "Loading data from file=$CSV_FILE into table=$TABLE_NAME in database=$DATABASE_NAME"
psql -c "\copy $TABLE_NAME FROM '$CSV_FILE' WITH (FORMAT CSV, DELIMITER ',', HEADER true);" $DATABASE_NAME

echo "Done."
