#!/usr/bin/python
import os
from flask import Flask, jsonify, request, redirect, url_for, send_from_directory
from werkzeug import secure_filename

UPLOAD_FOLDER = './uploads'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__, static_url_path='')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

tasks = [
    {
        'id': 1,
        'title': u'Buy groceries',
        'description': u'Milk, Cheese, Pizza, Fruit, Tylenol', 
        'done': False
    },
    {
        'id': 2,
        'title': u'Learn Python',
        'description': u'Need to find a good Python tutorial on the web', 
        'done': False
    }
]

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS


@app.before_request
def before_request():
    if os.path.exists('./uploads') is False:
        os.mkdir('./uploads')

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return redirect(url_for('uploaded_file',
                                    filename=filename))
    files = os.listdir('./uploads')
    resp = """
    <!doctype html>
    <title>File Handling in Flask</title>
    """
    resp += """
    <h1>Upload new File</h1>
    <form action="" method='post' enctype=multipart/form-data>
    <p><input type=file name=file>
    <input type=submit value=Upload>
    </form>
    <hr />
    <h2>Uploaded Files:</h2>
    <ol>
    """
    for i in files:
        resp += """<li><a href="/uploaded/%s">%s</a></li>""" % (i, i)
    resp += "</ol>"
    return resp


@app.route('/uploaded/')
@app.route('/uploaded/<name>')
def uploaded_file(name=None):
    if name:
        #return app.send_static_file('./uploads/'+name)
        return send_from_directory('./uploads', name)
    return redirect('/')

@app.route('/todo/api/v1.0/tasks', methods=['GET'])
def get_tasks():
    return jsonify({'tasks': tasks})

if __name__ == '__main__':
    app.run(debug=True, port=5001)
