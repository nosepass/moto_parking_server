This is the backend for the parking app. It just handles users and parking spot locations. It is a Rails application.

The db is Postgres with the uuid-ossp extension. The extension can be found in the postgresql-contrib package on Ubuntu and needs to be enabled on each database using 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'.
