import os
#from app.pdfs import create_pdf
from app import app
from StringIO import StringIO
from xhtml2pdf import pisa
from reportlab.pdfgen import canvas
from flask import Flask,\
    render_template, \
    redirect, \
    url_for, \
    Response, \
    request, \
    make_response
#from wheezy.http import HTTPResponse
 
# configuration
DEBUG = True
HOST='127.0.0.1'
PORT=5002
SECRET_KEY = 'hidden'
USERNAME = 'secret'
PASSWORD = 'secret'
# MAIL_SERVER='smtp.gmail.com'
# MAIL_PORT=465
# #587
# MAIL_USE_TLS = False
# MAIL_USE_SSL= True
# MAIL_USERNAME = os.environ.get('MAILA')
# MAIL_PASSWORD = os.environ.get('MAILP')

app.config.from_object(__name__)
# mail_ext = Mail(app)

@app.route('/pdf', methods=['GET'])
def gen_pdf():
    """
    using createPDF()
    """
    output = StringIO()
    pisa.CreatePDF(StringIO(render_template('temp.html').encode("UTF-8")), 
                   output)
    pisa.showLogging()
    response = make_response(output.getvalue())
    response.headers['Content-Disposition'] = "attachment; filename=file.pdf"
    response.mimetype = "application/pdf" #'application/x-download'
    return response

@app.route('/pdf2')
def gen_pdf2():
    """
    using pisaDocument()
    """
    output = StringIO()
    pdf = pisa.pisaDocument(StringIO(render_template('temp.html').encode("UTF-8")), 
                            output, 
                            encoding="UTF-8")
    pisa.showLogging()
    response = make_response(output.getvalue())
    response.headers['Content-Disposition'] = "attachment; filename=file.pdf"
    response.mimetype = "application/pdf" #'application/x-download'
    return response


@app.route('/pdf3')
def gen_pdf3():
    """
    using canvas / manual string styling
    """
    output = StringIO()
    p = canvas.Canvas(output)
    p.drawString(100, 100, 'Hello')
    p.showPage()
    p.save()
    response = make_response(output.getvalue())
    response.headers['Content-Disposition'] = "attachment; filename=file.pdf"
    return response
    # return HTTPResponse(
    #     output.getvalue(),
    #     mimetype='application/pdf')


# This route will prompt a file download with the csv lines
@app.route('/download')
def download():
    csv = """"REVIEW_DATE","AUTHOR","ISBN","DISCOUNTED_PRICE"
    "1985/01/21","Douglas Adams",0345391802,5.95
    "1990/01/12","Douglas Hofstadter",0465026567,9.95
    "1998/07/15","Timothy ""The Parser"" Campbell",0968411304,18.99
    "1999/12/03","Richard Friedman",0060630353,5.95
    "2004/10/04","Randel Helms",0879755725,4.50"""
    # We need to modify the response, so the first thing we 
    # need to do is create a response out of the CSV string
    response = make_response(csv)
    # This is the key: Set the right header for the response
    # to be downloaded, instead of just printed on the browser
    response.headers["Content-Disposition"] = "attachment; filename=books.csv"
    return response

@app.route('/')
def index():
    """
    Landing Page
    """
    # print request.base_url
    # print render_template('temp.html')
    return render_template('temp.html',
                           landing_page=True,
                           home=True,
                           something="haha")

# @app.route('/generate')
# def my_func():
#     subject = "Mail with PDF"
#     receiver = "arcsharm@redhat.com"
#     mail_to_be_sent = Message(subject=subject, recipients=[receiver])
#     mail_to_be_sent.body = "This email contains PDF."
#     pdf = create_pdf(render_template('temp.html'))
#     # mail_to_be_sent.attach("file.pdf", "application/pdf", pdf.getvalue())
#     # mail_ext.send(mail_to_be_sent)
#     # #return Response('done!')
#     # return pdf.getvalue()
#     response = make_response(pdf_out)
#     response.headers['Content-Disposition'] = "attachment; filename='file.pdf"
#     response.mimetype = 'application/pdf'
#     return response

if __name__ == '__main__':
    try:
        app.run(host = HOST,
                port = PORT,
                debug = DEBUG)
    except:
        raise
