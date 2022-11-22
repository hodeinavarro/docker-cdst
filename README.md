# docker-cdst
Repositorio con la información necesaria para el despliegue de Tryton en cdst mediante docker

## crear red para la conexión de contenedores
> docker network create tryton

## Run the Database Server

### crear volume para la consistencia de las DB
> docker volume create tryton-database

### Generate a Secure Password
> export POSTGRES_PASSWORD='your_top_secret_password'

### crear contenedor con postgres
> docker run \
>     --name tryton-postgres \
>     --env PGDATA=/var/lib/postgresql/data/pgdata \
>     --env POSTGRES_DB=tryton \
>     --env POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
>     --mount source=tryton-database,target=/var/lib/postgresql/data \
>     --network tryton \
>     --publish 127.0.0.1:5454:5432 \
>     --detach \
>     postgres

#### conectarse a la base de datos postgres de un contenedor (publish)
psql -h localhost -p 5454 -U postgres

#### conectarse a la base de datos postgres de un contenedor (no publish)
docker run -it --rm --network tryton postgres psql -h tryton-postgres -U postgres

### inicializar la base de datos
> docker run \
>     --env DB_HOSTNAME=tryton-postgres \
>     --env DB_PASSWORD=${POSTGRES_PASSWORD} \
>     --network tryton \
>     --interactive \
>     --tty \
>     --rm \
>     tryton/tryton \
>     trytond-admin -d tryton --all

## Run the Tryton Server

### crear volume para la consistencia de los archivos de Tryton
> docker volume create tryton-data

### crear contenedor con Tryton
> docker run \
>     --name tryton-cdst \
>     --env DB_HOSTNAME=tryton-postgres \
>     --env DB_PASSWORD=${POSTGRES_PASSWORD} \
>     --mount source=tryton-data,target=/var/lib/trytond/db \
>     --network tryton \
>     --publish 0.0.0.0:8000:8000 \
>     --detach \
>     tryton/tryton
