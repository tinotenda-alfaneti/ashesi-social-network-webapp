import firebase_admin
from firebase_admin import credentials, firestore

import functions_framework
from flask import request, jsonify

import json


firebase_admin.initialize_app()
db = firestore.client()
users_db = db.collection('users')
messages_db = db.collection('messages')

@functions_framework.http
def ash_network(request):

    if request.method == 'GET' and '/profile' in request.path:
        id = request.path.split('/')[-1]
        return get_user_profile(id)
    
    if request.method == 'POST' and '/profile' in request.path:
        return create_user()
    
    if (request.method == 'PUT' or request.method == 'PATCH') and '/profile' in request.path:
        return update_user()
    
    if request.method == 'POST' and '/message' in request.path:
        return create_message()
    
    else:
        return jsonify({"Error":"Request Error"}), 503


def get_user_profile(email):

    try:
        users_records = [data.to_dict() for data in users_db.stream()]
        for user in users_records:
            if user['email'] == email:
                response = jsonify(user)
                response.headers['Access-Control-Allow-Origin'] = '*'
                return response, 200
        response = jsonify({'ERROR': 'User Does Not Exist'})
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 404
    except:
        response = jsonify({'ERROR': 'Unknown Error'})
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 503


def create_user():

    try:
    
        new_student = json.loads(request.data)
        users_records = [doc.to_dict() for doc in users_db.stream()]
        if len(users_records) == 0:
            users_db.document(new_student['email']).set(new_student)
            response = jsonify(new_student)
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.headers["Content-Type"] = "application/json"
            return response, 200
        else:

            for student in users_records:
                if student['email'] == new_student['email']:
                    response = jsonify({'ERROR': 'User Already Exists'})
                    response.headers["Access-Control-Allow-Origin"] = "*"
                    response.headers["Content-Type"] = "application/json"
                    return response, 403
        
            users_records.append(new_student)
            users_db.document(new_student['email']).set(new_student)
            response = jsonify(new_student)
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.headers["Content-Type"] = "application/json"
            return response, 200
    
    except:
        response = jsonify({'ERROR': 'Unknown Error'})
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 503

def update_user():

    try:
        update_request = json.loads(request.data)
        updated_student = None
        data_to_update = {}
        users_records =  [data.to_dict() for data in users_db.stream()]
        
        # try updating
        for student in users_records:
            if student['student-id'] == update_request['student-id']:
                for key in update_request:
                    data_to_update[key] = update_request[key]
                updated_student = student
        if updated_student == None:

            response = jsonify({'ERROR': 'User Not Found'})
            response.headers["Access-Control-Allow-Origin"] = "*"
            response.headers["Content-Type"] = "application/json"
            return response, 404

        users_db.document(update_request['email']).set(data_to_update, merge=True)
        updated_student = users_db.document(update_request['email']).get()
        response = jsonify(updated_student.to_dict())
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 200
    except:
        response = jsonify({'ERROR': 'Unknown Error'})
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 503
    

def create_message():

    try:
    
        new_message = json.loads(request.data)
        messages_db.document().set(new_message)
        response = jsonify(new_message)
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 200
    
    except:
        response = jsonify({'ERROR': 'Unknown Error'})
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Content-Type"] = "application/json"
        return response, 503
