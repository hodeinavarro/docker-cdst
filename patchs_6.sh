#!/bin/sh

# Patch for fix files in trytond core

cp patchs/report.py /usr/local/lib/python3.7/dist-packages/trytond/report/report.py

cp patchs/stock_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/stock/locale/es.po

cp patchs/sale_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/sale/locale/es.po

cp patchs/purchase_es.po /usr/local/lib/python3.7/dist-packages/trytond/modules/purchase/locale/es.po

cp patchs/asset.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/account_asset/

cp patchs/account.xml /usr/local/lib/python3.7/dist-packages/trytond/modules/commission/

cp patchs/invoice.py /usr/local/lib/python3.7/dist-packages/trytond/modules/account_invoice/