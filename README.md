# Football

# Development

`mix deps.get` - Install dependencies
`mix ecto.setup` - Create and migrate your dev database
`docker build -t football_dev -f Dockerfile.development .` - Build the dev docker image
`docker run -p 4000:4000 -it football_dev:latest` - Run the dev docker image

(__On the first time only__)
`mix run priv/repo/seeds.exs` - Seed the dev database

# Production

## Setup
docker swarm init
docker swarm leave --force

## Deploying
docker build -t football_prod .
docker stack deploy --compose-file=docker-compose.yml prod

## Seeding
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

## Killing deployed containers
docker stack rm prod
