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
    print('<h3>PAY AN ORDER</h3>')
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    
    print('<label for="num">ORDER NUMBER:</label><br>')
    print('<input type="text" id="num" name="num"><br>')
    print('<label for="cust">CUSTOMER NAME:</label><br>')
    print('<input type="text" id="cust" name="cust">')
    print('<input type="submit" value="submit">')
    print('</form>')
    print('</div>')
    print('</div>')
    
    num = form.getvalue('num')
    cust = form.getvalue('cust')
    
    if num and cust is not None:
        sql = 'INSERT INTO pay VALUES(%(num)s, %(cust)s)'
        data = {'num':num, 'cust':cust}
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
