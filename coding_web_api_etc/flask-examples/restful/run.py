#!/usr/bin/python

from flask import Flask, render_template, request

UPLOAD_FOLDER = './uploads'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__, static_url_path='')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route('/')
def upload_file():
    resp = """
    <!doctype html>
    <title>forms Flask</title>
    """
    resp += """
    <h1>test form</h1>
    <form action="/post" method='post' enctype=multipart/form-data>
    <p><input type=text id="f1">
    <input type=text id="f2">
    <input type=submit value=Upload>
    </form>
    <hr />
    <ol>"""
    resp += "</ol>"
    return resp

@app.route('/get')
def get():
    # Get the parsed contents of the query string
    querystring = request.args
    # Render template
    return render_template('data.html', data = querystring, method = 'get')

@app.route('/post', methods = ['POST'])
def post():
    # Get the parsed contents of the form data
    form = request.form
    print form
    # Render template
    return render_template('data.html', data = form, method = 'post')

# Run
if __name__ == '__main__':
    app.run(
        host = "0.0.0.0",
        port = 5003,
        debug=True
    )
