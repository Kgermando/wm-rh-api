#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE work_rh;
	GRANT ALL PRIVILEGES ON DATABASE work_rh TO postgres;
EOSQL
