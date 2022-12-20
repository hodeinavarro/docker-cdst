echo "[INFO] Run. "

db="
RIKATAS
"

echo "[INFO] Inicia actualizacion. "
for i in ${db}
    do
        docker run \
        --env DB_HOSTNAME=tryton-postgres \
        --env DB_PASSWORD=${POSTGRES_PASSWORD} \
        --network tryton \
        --interactive \
        --tty \
        --rm \
        tryton/cdst2 \
        trytond-admin -d $i --all
    done

echo "[INFO] Inicia cron. "
for i in ${db}
    do
        docker rm -f tryton-cron-$i
        docker run \
        --name tryton-cron-$i \
        --link tryton-postgres:postgres \
        --network tryton \
        --env DB_PASSWORD=${POSTGRES_PASSWORD} \
        --detach \
        tryton/cdst2 \
        trytond-cron -d $i
    done

echo "[INFO] Done. "