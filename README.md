# Payment api

Api de pagamentos, feita durante a NLW#04

# Install

Subindo o banco de dados:
````
cd docker
docker-compose up -d
````

Subindo a aplicação
````
cd app
mix deps.get
mix deps.compile
mix phx.server
````