#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

print("Content-Type: text/html\n\n")
print('<!DOCTYPE html>')
print('<!DOCTYPE html>')
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
    print("<h3>NEW CLIENT</h3>")
    print('<div class="forms">')
    print('<form class="forms" action="" method="post">')
    print('<label for="cust">CLIENT NUMBER:</label><br>')
    print('<input type="text" id="cust" name="cust">')
    print('<label for="nome">NAME:</label><br>')
    print('<input type="text" id="nome" name="nome"><br>')
    print('<label for="mail">E-MAIL:</label><br>')
    print('<input type="text" name="mail" id="mail">')
    print('<label for="phone">PHONE:</label><br>')
    print('<input type="text" name="phone" id="phone">')
    print('<label for="add">ADDRESS:</label><br>')
    print('<input type="text" name="add" id="add">')
    print('<input type="submit" value="submit">')
    print("</form>")
    print("</div>")
    print("</div>")

    cust = form.getvalue('cust')
    nome = form.getvalue('nome')
    mail = form.getvalue('mail')
    phone = form.getvalue('phone')
    add = form.getvalue('add')

    if cust and nome and mail is not None:
        sql = 'INSERT INTO customer VALUES (%s, %s, %s, %s, %s);'
        data = (cust, nome, mail, phone, add)
        cursor.execute("INSERT INTO customer VALUES (%(cust)s, %(nome)s, %(mail)s, %(phone)s, %(add)s)",
                       {'cust': cust, 'nome': nome, 'mail': mail, 'phone': phone, 'add': add})
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
