# OBS-GUARAPUAVA

System used to complete the TCC 2 of the UTFPR Guarapuava to the Social Observatory of Guarapuava

## Run locally

To install OBS-Guarapuava locally follow these instructions:

1. **Prerequisite**

First you need to install the follow packages

 	```
 	nodejs
  	libpq-dev
  	Ruby
  	Rails
 	postgresql
 	postgresql-contrib
 	```

Its necessary to install the Bundler and the Rails gems

 	```
 	gem install bundler
 	gem install rails
 	```

2. **Clone the project**

Clone the project repository using the command

	`git clone https://github.com/valdineimoraes/ObservatorioSocialdeGuarapuava.git`
	
	`cd tsicms`

3. **Install dependencies**

	`bundle`

4. **Set up postgres password**

	`cp config/application.yml.example config/application.yml`

In this file change postgres username and password and host

    	```
	database: &database
  	db.username: postgres
  	db.password: postgres
  	db.host: localhost
    	```

5.  **Create the database, the tables and populate tables **

	```
	$ rails db:create
	$ rails db:migrate
	$ rails db:seed
 	$ rails db:populate
	```

6. **Run the application**

	```
	$ rails s
	```

Access the public namespace url [http://localhost:3000](http://localhost:3000)

Enter the following username and password: `email: teste@teste.com` and `password: 123456`

## References
* Ruby - https://www.ruby-lang.org/pt/documentation/installation/
* Rails - https://onebitcode.com/rails-linux/
* PostgreSQL - https://www.postgresql.org/download/linux/ubuntu/
* More Complete Installation Tutorial - https://nandovieira.com.br/configurando-ruby-rails-mysql-postgresql-git-no-ubuntu
