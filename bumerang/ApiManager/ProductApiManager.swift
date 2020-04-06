


import Foundation

import Alamofire
import SwiftyUserDefaults
import SwiftyJSON
import SVProgressHUD

class ProductApiManager: NSObject {
    
    class func uploadProductApi(title: String, catagoryID: String, room: String, heeating: String, furbished: String, fuel: String, gear: String, door: String, car: String, bed: String, person: String, captan: String, gender: String, size: String, color: String, price: String, priceType: String, deposit: String, description: String, image: [String], addr: String, lat: String, lng: String,zipCode: String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let request_URL = API_PRODUCT + UPLOAD_PRODUCT
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append("\(Defaults[.userId])".data(using:String.Encoding.utf8)!, withName: PARAMS.OWNER_ID)
                multipartFormData.append(catagoryID.data(using:String.Encoding.utf8)!, withName: PARAMS.CATAGORY_ID)
                multipartFormData.append(title.data(using:String.Encoding.utf8)!, withName: PARAMS.TITLE)
                multipartFormData.append(room.data(using:String.Encoding.utf8)!, withName: PARAMS.ROOM_NUMBER)
                multipartFormData.append(heeating.data(using:String.Encoding.utf8)!, withName: PARAMS.HEATING)
                multipartFormData.append(furbished.data(using:String.Encoding.utf8)!, withName: PARAMS.FURBISHED)
                multipartFormData.append(fuel.data(using:String.Encoding.utf8)!, withName: PARAMS.FUEL_TYPE)
                multipartFormData.append(gear.data(using:String.Encoding.utf8)!, withName: PARAMS.GEAR_TYPE)
                multipartFormData.append(door.data(using:String.Encoding.utf8)!, withName: PARAMS.DOOR_NUMBER)
                multipartFormData.append(car.data(using:String.Encoding.utf8)!, withName: PARAMS.CAR_TYPE)
                multipartFormData.append(bed.data(using:String.Encoding.utf8)!, withName: PARAMS.BED_CAPACITY)
                multipartFormData.append(person.data(using:String.Encoding.utf8)!, withName: PARAMS.PERSON_CAPACITY)
                multipartFormData.append(captan.data(using:String.Encoding.utf8)!, withName: PARAMS.CAPTAN)
                multipartFormData.append(gender.data(using:String.Encoding.utf8)!, withName: PARAMS.GENDER)
                multipartFormData.append(size.data(using:String.Encoding.utf8)!, withName: PARAMS.SIZE)
                multipartFormData.append(color.data(using:String.Encoding.utf8)!, withName: PARAMS.COLOR)
                multipartFormData.append(priceType.data(using:String.Encoding.utf8)!, withName: PARAMS.PRICE_TYPE)
                multipartFormData.append(price.data(using:String.Encoding.utf8)!, withName: PARAMS.PRICE_VAL)
                multipartFormData.append(deposit.data(using:String.Encoding.utf8)!, withName: PARAMS.DEPOSIT)
                multipartFormData.append(description.data(using:String.Encoding.utf8)!, withName: PARAMS.DESCRIPTION)
                multipartFormData.append(addr.data(using:String.Encoding.utf8)!, withName: PARAMS.ADDRESS)
                multipartFormData.append("\(lat)".data(using:String.Encoding.utf8)!, withName: PARAMS.LOCATION_LAT)
                multipartFormData.append("\(lng)".data(using:String.Encoding.utf8)!, withName: PARAMS.LOCATION_LNG)
                multipartFormData.append(zipCode.data(using:String.Encoding.utf8)!, withName: PARAMS.ZIP_CODE)
                
                
                
                
                for i in image{
                    
                      multipartFormData.append(URL(fileURLWithPath: i), withName: PARAMS.UPLOAD_IMAGE)
                    
                    print(i)
                }
                    
              
                    
                    
                    
               
                
                
        },
            to: request_URL,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _): upload.responseJSON { response in
                    
                    switch response.result {
                    case .failure: completion(false, nil)
                    case .success(let data):
                        let dict = JSON(data)
                        print(dict)
                        let result_code = dict[PARAMS.RESULT_MSG].stringValue
                        
                        if result_code == PARAMS.CODE_SUCESS {
                            let uploadInfo = dict[PARAMS.UPLOADINFO]
                            
                            print(response.result.value!)
                            
                            
                            completion(true, uploadInfo)
                          
                            
                            
                        } else {
                            completion(false, result_code)
                        }
                    }
                    }
                case .failure(let encodingError):
                    completion(false, nil)
                }
        })
    }
    
    
    class func getProductList(catagoryId: String, pageNum: String, roomNum: String, heating: String, gender: String, size: String, color: String, furbished: String, fuel: String, gear: String, carType: String, bedNum: String, personNum: String, captan: String, price: String, priceType: String, doorNum: String, deposit: String, completion: @escaping (_ success: Bool, _ response1 : Any?, _ response2: Any?) -> ()) {
        
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
                print(dict)
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
    
    
    class func rentProduct(ownerID: String, productID: String, startDate: String, endDate: String, rent_price: String, userMsg: String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let request_URL = API_RENT + REQUEST_RENT_PRODUCT
        let params = [
            PARAMS.USER_ID : "\(Defaults[.userId])",
            PARAMS.OWNER_ID : ownerID,
            PARAMS.PRODUCT_ID : productID,
            PARAMS.START_DATE : startDate,
            PARAMS.END_DATE : endDate,
            PARAMS.RENT_PRICE : rent_price,
            PARAMS.USER_MSG : userMsg
        ] as [String : Any]
        
        Alamofire.request(request_URL, method:.post, parameters:params).responseJSON { response in
        
        switch response.result {
            
            case .failure:
                completion(false, nil)
            
            case .success(let data):
            
                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue
                
                if result_code == PARAMS.CODE_SUCESS {
                    let uploadInfo = dict[PARAMS.UPLOADINFO]
                
                    completion(true, uploadInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
    
    class func getRentListOfOwner(pageNum: String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        
        let request_URL = API_RENT + GET_RENT_HISTORY_OWNER
        let params = [
            PARAMS.OWNER_ID : "\(Defaults[.userId])",
            PARAMS.PAGE_NUM : pageNum
            ] as [String : Any]
        
        Alamofire.request(request_URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {
                
            case .failure:
                completion(false, nil)
                
            case .success(let data):
                
                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue
                
                if result_code == PARAMS.CODE_SUCESS {
                    
                    completion(true, dict["request_history"])
                    
                } else {
                    completion(false, result_code)
                }
            }
        }
        
    }

    class func getRentListOfUser(pageNum: String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        
        let request_URL = API_RENT + GET_RENT_HISTORY_USER
        let params = [
            PARAMS.USER_ID : "\(Defaults[.userId])",
            PARAMS.PAGE_NUM : pageNum
            ] as [String : Any]
        
        Alamofire.request(request_URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {
                
            case .failure: completion(false, nil)
                
            case .success(let data):
                
                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue
                
                if result_code == PARAMS.CODE_SUCESS {
                    
                    completion(true, dict["request_history"])
                    
                } else {
                    completion(false, result_code)
                }
            }
        }
        
    }
    
}
