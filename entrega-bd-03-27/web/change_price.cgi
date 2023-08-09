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
    print('<h3>CHANGE PRODUCT PRICE</h3>')
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    
    print('<label for="sku">SKU:</label><br>')
    print('<input type="text" id="sku" name="sku"><br>')
    print('<label for="price">NEW PRICE:</label><br>')
    print('<input type="text" id="price" name="price">')
    print('<input type="submit" value="submit">')
    print('</form>')
    print('</div>')
    print('</div>')
    
    sku = form.getvalue('sku')
    price = form.getvalue('price')
    
    if sku and price is not None:
        sql = 'UPDATE product SET price = %(price)s WHERE SKU = %(sku)s'
        data = {'price':price, 'sku': sku}
        
        cursor.execute(sql, data)
        connection.commit()
        print('<script>window.location.href = "home_page.cgi";</script>')
    
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

