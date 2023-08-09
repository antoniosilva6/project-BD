#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

print("Content-Type: text/html\n\n")
print('<!DOCTYPE html>')
print("<html>")
print("<head>")
print('<link rel="stylesheet" type="text/css" href="./css/main.css">')
print("<title>ProjetoBD</title>")
print('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
print("</head>")
print("<body>")

connection = None
try:
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    print('<header class="cima">')
    print("<main>")
    print('<div class="header1">')
    print('<div class="logo-bd">')
    print('<img src="./img/bd-logo.png" >')
    print("</div>")
    print('<div class="logo-ist">')
    print('<img src="./img/ist-logo.png" >')
    print("</div>")
    print("</div>")
    print("</main>")
    print("</header>")
    print('<div class="box-degrade-form">')
    print("<h3>NEW ORDER</h3>")
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    print('<label for="num">ORDER NUMBER:</label><br>')
    print('<input type="text" id="num" name="num">')
    print('<label for="cust">CLIENT NUMBER:</label><br>')
    print('<input type="text" id="cust" name="cust">')
    print('<label for="sku">SKU:</label><br>')
    print('<input type="text" id="sku" name="sku"><br>')
    print('<label for="qty">QUANTITY:</label><br>')
    print('<input type="text" name="qty" id="qty">')
    print('<label for="dt">DATE:</label><br>')
    print('<input type="text" name="dt" id="dt">')
    print('<input type="submit" value="submit">')
    print("</form>")
    print("</div>")
    print("</div>")

    num = form.getvalue('num')
    cust = form.getvalue('cust')
    sku = form.getvalue('sku')
    qty = form.getvalue('qty')
    dt = form.getvalue('dt')

    if num and cust and dt is not None:
        sql = 'INSERT INTO orders VALUES(%(num)s, %(cust)s, %(dt)s);'
        data = {'num':num, 'cust':cust, 'dt': dt}
        cursor.execute(sql, data)
        connection.commit()
    if num and sku and qty is not None:
        sql = 'INSERT INTO contains VALUES(%(num)s, %(sku)s, %(qty)s);'
        data = {'num':num, 'sku':sku, 'qty':qty}
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

print("</body>")
print("</html>")
