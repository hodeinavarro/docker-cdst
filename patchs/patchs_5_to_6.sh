#!/bin/sh

# Patch for fix files in trytond core

cp report.py      /home/psk/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/report/report.py

cp stock_es.po    /home/psk/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/stock/locale/es.po

cp sale_es.po    /home/psk/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/sale/locale/es.po

cp purchase_es.po /home/psk/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/purchase/locale/es.po

cp asset.xml ~/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/account_asset/

cp account.xml ~/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/commission/

cp invoice.py ~/.virtualenvs/tryton60/lib/python3.8/site-packages/trytond/modules/account_invoice/
