# Sistema OBS-Guarapuava

## O que é o Sistema OBS-Guarapuava

Sistema utilizado para a conclusão do TCC 2 da UTFPR Guarapuava aplicado ao Observatório Social de Guarapuava

## Sobre

O Observatório Social da Cidade de Guarapuava - PR monitora de forma fiscalizadora as sessões da Câmara Municipal de vereadores. Atualmente um membro do Observatorio realiza relatorios de todas as sessões de vereadores. Estes relatorios são realizados manualmente, em folhas de papel. Após o preenchimento manual, os dados são transferidos tambem manualmente para  planilhas  do  Excel  para  que  em  seguida  sejam  gerados  relat ́orios para  publicação  em jornais, revistas e em redes sociais.
O problema desses relat ́orios  ́e que geram muitos gastos com folhas de papéis para as marcações e correndo o risco de perder os relatórios com o tempo e também muito espaço para serem armazenados em locais adequados.

Com  isso  o  sistema  OBS-Guarapuava  se  torna  muito  importante,  pois  tem  como principal objetivo a economia desses gastos, tanto como folhas de papel, tanto como espaços fisicos. O sistema salva todos os dados em um servidor em nuvem, podendo então o usuário acessar esses arquivos/relatórios de qualquer lugar com acesso a internet.

Outra parte muito importante do sistema é fornecer relatórios automatizados para diferentes  situações,  como:  participações  do  vereador  nas  sessões  (reuniões),  projetos  que o  vereador  propos,  bem  como  a  votação  desses  projetos  (se  foi  aprovado  ou  não), tipos  de projetos  propostos,  quantidade  de  projetos  que  foram  prospostos.  Esses  relatórios  gerados poderão ser publicados em jornais e postados em redes sociais para que atinja o máximo de pessoas possíveis para o conhecimento dessas informações

## Requisitos
* Ruby
* Rails 
* PostgreSQL

## Instalação

* Faça o Clone do projeto (https://github.com/valdineimoraes/ObservatorioSocialdeGuarapuava.git).

* Entre na pasta do projeto ` $ cd ObservatorioSocialdeGuarapuava `
* No seu terminal digite o seguinte comando:
  * `bundle install` (irá instalar todas as gem do sistema e suas dependências)

* Altere o usuário e a senha do seu Postgres BD no arquivo do projeto `config / database.yml`.
* Após isso digite: ` rails db: create`  (criar o banco de dados no BD Postgres) 

* Em seguida, execute as migrações para criar as tabelas no banco de dados:
  ` rails db: migrate db:seed db:populate`

* Para acessar o sistema digite no seu navegador de internet o seguinte endeço: `http://localhost:3000`
* Digite o seguinte usuário e senha: `email: teste@teste.com` e a `senha: 123456`
