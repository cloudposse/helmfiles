#!/usr/bin/env bash

echo "Starting Postgres DB initialization..."

# Create database if it doesn't already exist
createdb || echo "Database already exists!"

# Create storage tables
psql -f /vault/scripts/schema.sql

echo "Done!"
