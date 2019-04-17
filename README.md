Sistema para o Observatório Social de Guarapuava

Sistema utilizado para o TCC 2 da UTFPR Guarapuava

Sistema em RUBY ON RAILS



System Installation

Clone the design for your files.

Turn on your terminal the following command:
- bundle install (will install all system gems and their dependencies)

Change the user and password of your Postgres BD in the Project config/database.yml file and then run the following command on your terminal:
- rails db: create (create the database in BD Postgres)

Then run the migrations to make the tables in the database:
- rails db: migrate db:seed db:populate

Para acessar o sistema
email: teste@teste.com
senha: 123456
