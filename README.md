# Football

This is my solution for Derivco technical evalutation. The original exercise is in `Technical exercise.pdf` at the root of the project.

## Overview

The Football app is an read-only API that displays results for football matches, which can also be filtered by league and/or season.

Documentation for the API has been written using Swagger, and be accessed in the endpoint `/api/swagger` once the application is running. See [Development](#development) for more information.

The app has been written in Elixir using the Phoenix framework, exposing http endpoints. There are two variants: one for JSON and one for protocol buffers.

Docker has been setup with two variants. One simplified setup for development and one more complete production setup. The production setup has 4 containers as follows:

```
HAProxy
|-- football_prod
|-- football_prod
|-- football_prod
```

The HAProxy is load balancing traffic between the 3 instances with the default round-robin distribution.

## Getting started

You'll need to have installed:

- elixir 1.8
- erlang 21
- docker
- postgres

For elixir and erlang, you can use [asdf](https://github.com/asdf-vm/asdf), as configured per `.tool-versions` file.

You might have to adjust postgres to accept all connections, [check here for mor info](https://stackoverflow.com/questions/3278379/how-to-configure-postgresql-to-accept-all-incoming-connections). This will be necessary if you get connection errors when trying to run the application.

## Development

`mix deps.get` - Install dependencies  
`mix ecto.setup` - Create and migrate your dev database  
`docker build -t football_dev -f Dockerfile.development .` - Build the dev docker image  
`docker run -p 4000:4000 -it football_dev:latest` - Run the dev docker image  

(__On the first time only__)  
`mix run priv/repo/seeds.exs` - Seed the dev database

### API documentation

- You can open Swagger API documentation at `http://localhost:4000/api/swagger`.  
- You can re-generate or update it by running `mix phx.swagger.generate`.  

### Code documentation

`mix docs && open doc/index.html` 

### Tests & Coverage

- Run tests with `mix test`
- Run coverage with [`mix coveralls`](https://hexdocs.pm/excoveralls/Mix.Tasks.Coveralls.html)
  - To generate prettyfied coverage html and check coverage line-by-line you can run `mix coveralls.html && open cover/excoveralls.html`

### Static Code Analysis

Credo is a static code analysis tool for the Elixir language with a focus on teaching and code consistency.

- Run credo with `mix credo`

### Dialyzer

Dialyzer can analyze code with typespec to find type inconsistencies and possible bugs.

* Run dialyzer with `mix dialyzer`

Be aware this takes a while to run for the first time. Runs after the first will be a lot faster.

--------

## Production

### Setup
`docker swarm init`  
`docker swarm leave --force`

### Deploying
`docker build -t football_prod .`  
`docker stack deploy --compose-file=docker-compose.yml prod`

### Seeding
(only do this once, the very first time, as it will populate the database)

Find the docker id of one of the *football_prod* running containers 
`docker ps`


```bash
CONTAINER ID        IMAGE                        
dc586133baf2        dockercloud/haproxy:latest   
85c9c350a9d2        football_prod:latest <- #lets use this one for example
509db6d24005        football_prod:latest      
c7f958a24a13        football_prod:latest         
```

Now run the seed command replacing the container id  
`docker exec -it 85c9c350a9d2 ./bin/football seed`

### Killing deployed containers
`docker stack rm prod`
