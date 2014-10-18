from xhtml2pdf import pisa
from cStringIO import StringIO
#from StringIO import StringIO

# from celery import Celery

# app = Celery('pdftasks', backend='amqp', broker='amqp://')

# @app.task
def create_pdf(pdf_data):
    pdf = StringIO()
    pisa.CreatePDF(StringIO(pdf_data.encode('utf-8')), pdf)
    return pdf
