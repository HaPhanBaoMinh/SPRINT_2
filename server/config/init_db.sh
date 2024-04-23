#!/bin/bash
set -e

psql --username "$POSTGRES_USER"
CREATE DATABASE pernstore;
\q

psql -U postgres pernstore < /docker-entrypoint-initdb.d/init.sql
