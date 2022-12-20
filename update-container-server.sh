echo "[INFO] Run. "

db="
RIKATAS
"
echo "[INFO] Inicia servidor. "
for i in ${db}
    do
        docker rm -f tryton-$i
        docker run \
            --name tryton-$i \
            --env DB_HOSTNAME=tryton-postgres \
            --env DB_PASSWORD=${POSTGRES_PASSWORD} \
            --mount source=tryton-data,target=/var/lib/trytond/db \
            --network tryton \
            --publish 0.0.0.0:8002:8000 \
            --detach \
            tryton/cdst2
    done

echo "[INFO] Done. "