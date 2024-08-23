# from flask import Flask, render_template, request, flash,redirect,session,url_for
# import mysql.connector
# # import cv2 as cv
# # import keras_ocr
# # import re
# # import numpy as np
# # import tensorflow as tf
# # from mysql.connector import MultiResultSet
# # import torch
# # import torchvision.transforms as transforms
# # import torchvision.models as models
# # import cv2
# from PIL import Image
# from transformers import *
# # import YOLO
# import hashlib

# # import os


# app = Flask(__name__)
# # app.secret_key = "123"


# # model = YOLO('best.pt')


# # model = YOLO('npbest.pt')
# # model.predict(
# # source="myimg1.jpg",
# #     conf=0.25,
# #             save=True, save_txt=True
# #         )



# # MySQL configuration
# eemail = 'hassanrana10@gmail.com'

# mysql_host = 'localhost'
# mysql_user = 'root'
# mysql_password = ''
# mysql_db = 'mbilal'
# conn = mysql.connector.connect(host=mysql_host, user=mysql_user, password=mysql_password, database=mysql_db)
# cursor = conn.cursor()
# personid = 0
# @app.route('/')
# def index():
#     return render_template('mylogin.html')



# @app.route('/mylogin')
# def signup():
#     return render_template('myform.html')


# @app.route('/patientrecords/<int:personid>')
# def PatientRecord(personid):
#     # cursor.execute("SELECT * FROM patientss WHERE patient_id = %s", (personid,))
#     cursor.execute("SELECT * FROM patients WHERE patient_id = %s AND eemail = %s", (personid, eemail))

#     data = cursor.fetchall()
#     return render_template('patientrecords.html', data=data,personid=personid)

# @app.route('/myform')
# def signin():
#     return render_template('mylogin.html')

# @app.route('/details', methods=['POST'])
# def details():
#     data = request.get_json()
#     personid = data['personid']

#     print("Person id is = ",personid)
#     return redirect(url_for('PatientRecord', personid=personid))

# @app.route('/Records')
# def Records():
#     try:
#         # cursor.execute("SELECT * FROM patient")
#         # cursor.execute("select * FROM patientss GROUP by (patient_id)")
#         cursor.execute("SELECT * FROM patients WHERE eemail = %s GROUP BY patient_id HAVING COUNT(*) >= 1", (eemail,))

#         data = cursor.fetchall()
#         return render_template('Records.html', data=data)
#     except Exception as e:
#         print("ERROR : " + str(e))

#     flash("Error in Fetching Data")
#     return redirect('Home')

# @app.route('/Home')
# def Home():
#     return render_template('index.html', uploaded_image = None, resultant_image = None)

# @app.route('/mylogin', methods=['POST','GET'])
# def mylogin():
#     if request.method == 'POST':

#         global eemail

#         eemail = request.form['email']
#         password = request.form['password']
#         query = "SELECT * FROM user WHERE email = %s"
#         values = (eemail,)
#         cursor.execute(query, values)
#         user = cursor.fetchone()
#         print("login password",password)
#         if user:
#             # Email exists in database, verify password
#             hashed_password = user[3].encode('utf-8')
#             print("Login hased password",hashed_password) 
#             if user[3] == hashlib.sha256(password.encode('utf-8') + eemail.encode('utf-8')).hexdigest():
#                 print("Login hased password",hashed_password)
#                 flash('Valid email and password', 'success')
#                 return render_template('index.html')
#             else:
#                 flash('Invalid Email and password', 'failure')
#                 return render_template('mylogin.html')
#         else:
#             flash('Invalid email or password', 'error')
#             return render_template('mylogin.html')
#     else:
#         return render_template('mylogin.html')




# @app.route('/register', methods=['POST', 'GET'])
# def register():
#     if request.method == 'POST':
#         # img = request.files['image']
#         print('Enterrrrrrrrrrrrrrrr')
#         name = request.form['name']

#         global eemail
#         eemail = request.form['email']
#         password = request.form['password']
#         hashed_password = hashlib.sha256(password.encode('utf-8') + eemail.encode('utf-8')).hexdigest()
#         print(hashed_password)

#     #     query = "SELECT * FROM user WHERE email = %s"
#     #     values = (eemail,)
#     #     cursor.execute(query, values)
#     #     result = cursor.fetchone()
#     #     if result is not None:
#     #         # Email already exists in database
#     #         flash("Email already exists")
#     #         return render_template('myform.html', message="Email already exists")
#     #     else:
#     #         # Email does not exist, insert new user into database
#     #         query = "INSERT INTO user (name, email, password) VALUES (%s, %s, %s)"
#     #         values = (name, eemail, hashed_password)
#     #         cursor.execute(query, values)
#     #         conn.commit()
#     #         flash('Registration successful', 'success')
#     #         return render_template('index.html')
#     # else:
#     #     return render_template('myform.html')


# @app.route('/login')
# def login():
#     message = request.args.get('message')
#     return render_template('mylogin.html', message=message)


# @app.route('/submit-form', methods=['POST'])
# def handle_form_submission():
#     if request.method == "POST":
#         myImageFile = request.files['file']
        
         
#         # img = cv.imdecode(np.frombuffer(myImageFile.read(), np.uint8), cv.IMREAD_UNCHANGED)
#         # img1 = cv.imread("myImageFile")
        
#         print(myImageFile)
#         x=Image.open(myImageFile)
#         x.save("2.jpg")
        
#         # img_data = np.frombuffer(myImageFile.read(), np.uint8)
#         # img1 = cv.imdecode(img_data, cv.IMREAD_UNCHANGED)
        
#         # img_array = np.array(img1)

        
        
        
#         patientImageName = myImageFile.filename
        
#         # img1 = Image.open(myImageFile)
        
#         # img1=img1.convert("RGB")
        
#         # img1.save("1.jpg")
        
        
        
        
#         results=model.predict(
#         source="2.jpg",
#             conf=0.25,
#                     save=True, save_txt=True
#                 )

#         # Define the path to the directory
#         # dir_path = r"E:/copy_mitweb/runs/detect"

#         # # Get the list of files and directories in the directory
#         # files = os.listdir(dir_path)

#         # # Count the number of directories in the directory
#         # num_dirs = 0
#         # for file in files:
#         #     if os.path.isdir(os.path.join(dir_path, file)):
#         #         num_dirs += 1

#         # print(num_dirs)
        
#         img_path = fr"D:\fypmodels\copy_mitwebb\runs\detect\predict\2.jpg"
#         print("________________________")
#         print(results)
#         # Load the image using cv.imread()
#         img = Image.open(img_path)
#         # img.show()
        
#         # cv.imshow('Image', img)

#         # # Wait for a key event
#         # cv.waitKey(0)

#         #         # Close all windows
#         # cv.destroyAllWindows()

#         # img1=np.array(x)
        
        
#         # img = np.array(img)
#         # img = request.files['file'].read()
        

#         # Get the form data
        
#         name = request.form.get('name')
#         patient_id = request.form.get('id')
#         # doctorid=request.form.get('doctorid')
#         prob="hello, ali"
#         patientImageName = myImageFile.filename
#         patientImageResultsName = "resultant " + patientImageName
        

#         x.save("static/upload_images/" + patientImageName)
#         img.save("static/results_images/" + patientImageResultsName)
        
        
#         # cv.imwrite("static/upload_images/" + patientImageName, img1)
#         # cv.imwrite("static/results_images/" + patientImageResultsName, img)

#         # store image to respective folders in static folder
#         try:        
#             query = "INSERT INTO patients (patient_id, name, uploaded_image, results_image,prob,time1,eemail) VALUES (%s, %s, %s, %s, %s,NOW(),%s)"
            
#             values = (patient_id, name, patientImageName, patientImageResultsName,prob,eemail)
#             cursor.execute(query, values)
#             conn.commit()
#         except Exception as e:
#             print("Error Found : ", str(e))

#     return render_template('index.html', uploaded_image = "/static/upload_images/" + patientImageName, resultant_image = "/static/results_images/" + patientImageResultsName)

# if __name__ == '__main__':
#     app.run(debug=True)    

from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api',methods = ['GET'])
def returnascii():
    d = {}
    inputchr = str(request.args['query'])
    answer = str(ord(inputchr))
    d['output'] = answer
    return d

if __name__ =="__main__":
    app.run(debug=True,port=5000)