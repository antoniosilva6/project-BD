#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

print("Content-Type: text/html\n\n")
print("<html>")
print("<head>")
print('<link rel="stylesheet" type="text/css" href="./css/main.css">')
print("<title>ProjetoBD</title>")
print('<script src="./js/teste.js"></script>')
print('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
print("</head>")
print("<body>")

connection = None

try:
    connection = psycopg2.connect(login.credentials)
    connection.autocommit = False
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
    print("<h3>REMOVE CLIENT</h3>")
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    print('<label for="cust">CLIENT NUMBER:</label><br>')
    print('<input type="text" id="cust" name="cust">')
    print('<input type="submit" value="submit">')
    print("</form>")
    print("</div>")
    print("</div>")

    cust = form.getvalue('cust')

    if cust is not None:
        cursor.execute("SELECT order_no FROM orders WHERE cust_no = %(cust)s", {'cust':cust})
        order_numbers = cursor.fetchall()
        for order_number in order_numbers:
            cursor.execute("DELETE FROM contains WHERE order_no = %(para)s", {'para':order_number[0]})
            cursor.execute("DELETE FROM process WHERE order_no = %(para2)s", {'para2':order_number[0]})
        sql = 'DELETE FROM pay WHERE cust_no = %(cust)s;'
        data = {'cust':cust}
        cursor.execute(sql, data)
        sql = 'DELETE FROM orders WHERE cust_no = %(cust)s;'
        data = {'cust':cust}
        cursor.execute(sql, data) 
        sql = 'DELETE FROM customer WHERE cust_no = %(cust)s;'
        data = {'cust':cust}
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
