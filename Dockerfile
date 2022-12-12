FROM tryton/tryton:6.0
USER root
RUN mkdir /trytoncdst
COPY . /trytoncdst
WORKDIR /trytoncdst
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    make build-essential gnupg2 unixodbc-dev python3-dev \
    python3-gi python3-gi-cairo libcairo2-dev libreoffice\
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y curl apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
RUN pip3 install -r requirements.txt
RUN mv move.py /usr/local/lib/python3.7/dist-packages/trytond/modules/account/move.py
RUN ./modules-psk.sh
RUN mv patchs/report.py /usr/local/lib/python3.7/dist-packages/trytond/report/report.py
RUN mv patchs/stock_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/stock/locale/es.po
RUN mv patchs/sale_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/sale/locale/es.po
RUN mv patchs/purchase_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/purchase/locale/es.po
RUN mv patchs/asset.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/account_asset/
RUN mv patchs/account.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/commission/
RUN mv patchs/invoice.py /usr/local/lib/python3.7/dist-packages/trytond/modules/account_invoice/