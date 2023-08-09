#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

print('Content-type:text/html\n\n')
print('<!DOCTYPE html>')
print('<html>')
print('<head>')
print('<link rel="stylesheet" type="text/css" href="./css/main.css">')
print('<title>ProjetoBD</title>')
print('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
print('</head>')

print('<style>')
print('input[type=text] {')
print('height: 40px;')
print('width: 600px;')
print('}')

print('input[type=submit] {')
print('height: 40px;')
print('width: 300px;')
print('margin-left: 150px;')
print('margin-top: 20px;')
print('}')
print('</style>')
print('<body>')

connection = None

try:
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
    cursor = connection.cursor()
    
    print('<header class="cima">')
    print('<main>')
    print('<div class="header1">')
    print('<div class="logo-bd">')
    print('<img src="./img/bd-logo.png">')
    print('</div>')
    print('<div class="logo-ist">')
    print('<img src="./img/ist-logo.png">')
    print('</div>')
    print('</div>')
    print('</main>')
    print('</header>')
    
    print('<div class="box-degrade-form">')
    print('<h3>REGISTER SUPPLIER</h3>')
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    
    print('<label for="tin">TIN:</label><br>')
    print('<input type="text" id="tin" name="tin">')
    print('<label for="name">NAME:</label><br>')
    print('<input type="text" id="name" name="name">')
    print('<label for="address">ADDRESS:</label><br>')
    print('<input type="text" name="address" id="address">')
    print('<label for="date">DATE:</label><br>')
    print('<input type="text" name="date" id="date">')

    print('<label for="sku">PRODUCT SKU:</label><br>')
    print('<input type="text" id="sku" name="sku"><br>')
    print('<label for="nameP"> PRODUCT NAME:</label><br>')
    print('<input type="text" id="namep" name="namep">')
    print('<label for="descr"> PRODUCT DESCRIPTION:</label><br>')
    print('<input type="text" name="descr" id="descr">')
    print('<label for="price"> PRODUCT PRICE:</label><br>')
    print('<input type="text" name="price" id="price">')
    print('<label for="ean">PRODUCT EAN:</label><br>')
    print('<input type="text" name="ean" id="ean">')

    print('<input type="submit" value="SUBMIT">')
    print('</form>')
    print('</div>')
    print('</div>')
    
    tin = form.getvalue('tin')
    name = form.getvalue('name')
    address = form.getvalue('address')
    date = form.getvalue('date')

    sku = form.getvalue('sku')
    namep = form.getvalue('namep')
    descr = form.getvalue('descr')
    price = form.getvalue('price')
    ean = form.getvalue('ean')
    
    # Check if SKU already exists in the product table
    cursor.execute('SELECT SKU FROM product WHERE SKU = %s', (sku,))
    existing_sku = cursor.fetchone()

    if not existing_sku and namep and price and ean is not None:

        cursor.execute("INSERT INTO product VALUES (%(sku)s, %(namep)s, %(descr)s, %(price)s, %(ean)s)", 
                       {'sku': sku, 'namep': namep, 'descr': descr, 'price': price, 'ean': ean})

    if existing_sku:

        # Insert the new supplier into the supplier table
        sql = 'INSERT INTO supplier VALUES (%s, %s, %s, %s, %s)'
        data = (tin, name, address, sku, date)
        cursor.execute("INSERT INTO supplier VALUES (%(tin)s, %(name)s, %(address)s, %(sku)s, %(date)s)",
                       {'sku': tin, 'namep': name, 'descr': address, 'price': sku, 'ean': date})
        print('<script>window.location.href = "add_succ.cgi";</script>')
        
    
    connection.commit()
        
    cursor.close()
except Exception as e:
	# Print errors on the webpage if they occur
	print('<h1>An error occurred.</h1>')
	print('<p>{}</p>'.format(e))
finally:
	if connection is not None:
		connection.close()
print('</body>')
print('</html>')