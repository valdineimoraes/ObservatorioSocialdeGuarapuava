# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

System Installation


Clone the design for your files.

Turn on your terminal the following command:
- bundle install (will install all system gems and their dependencies)

Change the user and password of your Postgres BD in the Project config/database.yml file and then run the following command on your terminal:
- rails db: create (create the database in BD Postgres)

Then run the migrations to make the tables in the database:
- rails db: migrate

After that run the seeders to make the popular tables in the database:
- rails db: seed
