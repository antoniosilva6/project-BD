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
print('width:  600px;')
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
    print('<h3>REMOVE SUPPLIER</h3>')
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    print('<label for="tin">TIN:</label><br>')
    print('<input type="text" id="tin" name="tin"><br>')
    print('<input type="submit" value="SUBMIT">')
    print('</form>')
    print('</div>')
    print('</div>')
    
    tin = form.getvalue('tin')

    cursor.execute("SELECT sku FROM supplier WHERE TIN = %(tin)s", {'tin':tin})
    sku_numbers = cursor.fetchall()
    if(sku_numbers):
        cursor.execute("SELECT TIN FROM supplier WHERE SKU = %(para)s", {'para':sku_numbers[0]})
        tin_numbers = cursor.fetchall()
    
    if(sku_numbers):
        if(len(tin_numbers) == 1):
            sql = 'DELETE FROM supplier WHERE SKU = %(para)s;'
            data = {'para':sku_numbers[0]}
            cursor.execute(sql, data)
            cursor.execute("SELECT order_no FROM contains WHERE SKU = %(para)s", {'para':sku_numbers[0]})
            order_numbers = cursor.fetchall()
            sql = 'DELETE FROM contains WHERE SKU = %(para)s;'
            data = {'para':sku_numbers[0]}
            cursor.execute(sql, data)
            for order_number in order_numbers:
                cursor.execute("DELETE FROM orders WHERE order_no = %(para)s", {'para':order_number[0]})
            sql = 'DELETE FROM product WHERE SKU = %(para)s;'
            data = {'para':sku_numbers[0]}
            cursor.execute(sql, data)
            connection.commit()
    elif tin is not None:
        sql = 'DELETE FROM supplier WHERE TIN = %(tin)s;'
        data = {'tin':tin}
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
