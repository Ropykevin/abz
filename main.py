import admin
import customer
import sales
import sites
import store
import cashier

if __name__ == '__main__':
    admin.app.run(debug=True)
    customer.app.run(debug=True)
    sales.app.run(debug=True)
    sites.app.run(debug=True)
    store.app.run(debug=True)
    cashier.app.run(debug=True)