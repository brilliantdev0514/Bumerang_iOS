//
//  MyinfoApiManager.swift
//  bumerang
//
//  Created by RMS on 10/26/19.
//  Copyright © 2019 RMS. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyUserDefaults
import SwiftyJSON

class MyinfoApiManager: NSObject {
    
    class func getMyProducts(catagoryId: String, pageNum: String, roomNum: String, heating: String, gender: String, size: String, color: String, furbished: String, fuel: String, gear: String, carType: String, bedNum: String, personNum: String, captan: String, price: String, priceType: String, doorNum: String, deposit: String, completion: @escaping (_ success: Bool, _ response1 : Any?, _ response2: Any?) -> ()) {
        
        let request_URL = API_PRODUCT + GET_ALL_PRODUCT
        let params = [
            PARAMS.CATAGORY_ID : catagoryId,
            PARAMS.PAGE_NUM : pageNum,
            PARAMS.ROOM_NUMBER : roomNum,
            PARAMS.HEATING : heating,
            PARAMS.GENDER : gender,
            PARAMS.SIZE : size,
            PARAMS.COLOR : color,
            PARAMS.FURBISHED : furbished,
            PARAMS.FUEL_TYPE : fuel,
            PARAMS.CAR_TYPE : carType,
            PARAMS.BED_CAPACITY : bedNum,
            PARAMS.PERSON_CAPACITY : personNum,
            PARAMS.CAPTAN : captan,
            PARAMS.PRICE_VAL : price,
            PARAMS.PRICE_TYPE : priceType,
            
            PARAMS.GEAR_TYPE : gear,
            PARAMS.DOOR_NUMBER : doorNum,
            PARAMS.DEPOSIT : deposit
            ] as [String : Any]

        Alamofire.request(request_URL, method:.post, parameters:params).responseJSON { response in

            switch response.result {

            case .failure:
                completion(false, nil, nil)

            case .success(let data):

                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue
                
                if result_code == PARAMS.CODE_SUCESS {
                    let productList = dict[PARAMS.PRODUCTLIST_CATAOGRY]
                    let adsList = dict[PARAMS.PRODUCTLIST_CATAOGRY]
                    
                    completion(true, productList, adsList)
                } else {
                    completion(false, result_code, nil)
                }
            }
        }
    }
    
}
