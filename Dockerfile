FROM tryton/tryton:6.0
USER root
RUN mkdir /trytoncdst
COPY . /trytoncdst
WORKDIR /trytoncdst
RUN mv move.py /usr/local/lib/python3.7/dist-packages/trytond/modules/account/move.py
RUN mv patchs/report.py /usr/local/lib/python3.7/dist-packages/trytond/report/report.py
RUN mv patchs/stock_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/stock/locale/es.po
RUN mv patchs/sale_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/sale/locale/es.po
RUN mv patchs/purchase_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/purchase/locale/es.po
RUN mv patchs/asset.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/account_asset/
RUN mv patchs/account.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/commission/
RUN mv patchs/invoice.py /usr/local/lib/python3.7/dist-packages/trytond/modules/account_invoice/
RUN mv trytond.conf /etc/trytond.conf

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    make build-essential gnupg2 unixodbc unixodbc-dev python3-dev \
    python3-gi python3-gi-cairo libcairo2 libcairo2-dev libreoffice \
    curl apt-transport-https ca-certificates g++ \
    libpango-1.0-0 libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 libffi-dev shared-mime-info \
    libodbc1 wget \
    # odbc-postgresql
    && rm -rf /var/lib/apt/lists/*

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17

RUN wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.19-linux-glibc2.12-x86-64bit.tar.gz \
    && tar xvf mysql-connector-odbc-8.0.19-linux-glibc2.12-x86-64bit.tar.gz && cd mysql-connector-odbc-8.0.19-linux-glibc2.12-x86-64bit \
    # Get older version as well
    && wget https://dev.mysql.com/get/Downloads/Connector-ODBC/5.3/mysql-connector-odbc-5.3.14-linux-glibc2.12-x86-64bit.tar.gz \
    && tar xvf mysql-connector-odbc-5.3.14-linux-glibc2.12-x86-64bit.tar.gz && cd mysql-connector-odbc-5.3.14-linux-glibc2.12-x86-64bit \
    && cp bin/* /usr/local/bin && cp lib/* /usr/local/lib \
    && myodbc-installer -a -d -n "MySQL ODBC 5.3 Driver" -t "Driver=/usr/local/lib/libmyodbc5w.so" \
    && myodbc-installer -a -d -n "MySQL ODBC 5.3" -t "Driver=/usr/local/lib/libmyodbc5a.so"

# Replace psql odbc driver path with full path
# RUN sed -i 's/psqlodbc/\/usr\/lib\/x86_64-linux-gnu\/odbc\/psqlodbc/g' /etc/odbcinst.ini

RUN pip3 install -r requirements.txt
RUN ./modules-psk.sh