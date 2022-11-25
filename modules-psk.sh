#!/bin/sh

# Install modules
echo "[INFO] Installing trytonpsk modules... "

modules="
trytonpsk-account_bank_statement
trytonpsk-account_co_pyme
trytonpsk-account_col
trytonpsk-account_exo
trytonpsk-account_invoice_discount
trytonpsk-account_statement_co
trytonpsk-account_stock_latin
trytonpsk-account_voucher
trytonpsk-analytic_co
trytonpsk-analytic_payroll
trytonpsk-analytic_report
trytonpsk-analytic_sale_pos
trytonpsk-analytic_voucher
trytonpsk-collection
trytonpsk-commission_global
trytonpsk-company_department
trytonpsk-company_operation
trytonpsk-electronic_invoice_co
trytonpsk-electronic_payroll
trytonpsk-email
trytonpsk-invoice_report
trytonpsk-party_personal
trytonpsk-product_reference
trytonpsk-purchase_co
trytonpsk-purchase_discount
trytonpsk-reports
trytonpsk-sale_charge
trytonpsk-sale_goal
trytonpsk-sale_pos
trytonpsk-sale_pos_frontend
trytonpsk-sale_salesman
trytonpsk-sale_shop
trytonpsk-staff
trytonpsk-staff_access
trytonpsk-staff_access_extratime
trytonpsk-staff_co
trytonpsk-staff_contracting
trytonpsk-staff_event
trytonpsk-staff_loan
trytonpsk-staff_payroll
trytonpsk-staff_payroll_co
trytonpsk-stock_co
trytoncdst-conector
"

# for i in ${modules}
#     do
#         git clone https://bitbucket.org/presik/trytonpsk-$i.git
#     done
# echo "[INFO] Download completed. "

for i in ${modules}
    do
        cd $i
        python3 setup.py install
        cd ..
        rm -r $i
    done
echo "[INFO] Done. "
