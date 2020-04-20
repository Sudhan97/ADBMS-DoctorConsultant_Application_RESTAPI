from flask import request 
from flask_restful import Resource
from http import HTTPStatus

from utils.dbconn import connection
from predict_model.disease_list import DISEASE_LIST
from utils.db_helper import get_dictformat, get_listformat

import numpy as np 
import pandas as pd
import pickle


class PredictResource(Resource):

    def post(self):
        
        if connection is None: return {'message' : 'No Connection'}, HTTPStatus.BAD_REQUEST
        model = pickle.load(open("E:\model.pkl", 'rb'))

        data = request.get_json()
        if data is None:    return {"message":"No symptoms submitted"}, HTTPStatus.BAD_REQUEST

        symptoms = [ data[sym] for sym in data ]
        symptom_record = np.zeros(len(DISEASE_LIST))
            
        for symptom in symptoms:
            if symptom in DISEASE_LIST:
                ind = DISEASE_LIST.index(symptom)
                symptom_record[ind] = 1
        symptom_record = [list(symptom_record)]
        data_record = pd.DataFrame(list(symptom_record), columns=DISEASE_LIST)
        predicted_disease = model.predict(data_record)
        predicted_disease = list(predicted_disease)
    
        if len(predicted_disease) != 0: 
            return { "disease": predicted_disease }

        return {"disease" : "No disease recorded with the given symptoms"}, HTTPStatus.OK

        
    
