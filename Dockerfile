FROM tryton/tryton:6.0
USER root
RUN mkdir /trytoncdst
COPY . /trytoncdst
WORKDIR /trytoncdst
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    make build-essential gnupg2 unixodbc-dev python3-dev \
    python3-gi python3-gi-cairo libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y curl apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
RUN pip3 install -r requirements.txt
RUN ./modules-psk.sh
