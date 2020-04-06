
import Foundation
import Alamofire
import SwiftyUserDefaults
import SwiftyJSON

class UserApiManager: NSObject {
    
    class func signup(fname : String, lname : String, email: String, pwd: String,user_type : String, auth_type : String, completion: @escaping (_ success: Bool, _ response : Any?) -> ()) {
        
        let lat = "0.0"
        let lng = "0.0"
        
        let URL = API_USER + SIGNUP
        let params = [
            PARAMS.FIRSTNAME : fname,
            PARAMS.LASTNAME : lname,
            PARAMS.EMAIL : email,
            PARAMS.PASSWORD : pwd,
            PARAMS.USER_TYPE : user_type,
            PARAMS.AUTH_TYPE : auth_type,
            PARAMS.LOCATION_LAT : lat,
            PARAMS.LOCATION_LNG : lng,
            PARAMS.DEVICE_TOKEN: deviceTokenString
            ] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {
                
            case .failure:
                completion(false, nil)
                
            case .success(let data):
                
                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue
                
                if result_code == PARAMS.CODE_SUCESS {
                    let userInfo = dict[PARAMS.USERINFO]
                    completion(true, userInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
    class func login(email : String, pwd : String, auth_type : String, completion : @escaping (_ success: Bool, _ response : Any?) -> ()) {

        let URL = API_USER + LOGIN
        let params = [
            PARAMS.EMAIL : email,
            PARAMS.PASSWORD : pwd,
            PARAMS.AUTH_TYPE : auth_type,
            PARAMS.DEVICE_TOKEN: deviceTokenString
            
            ] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {

            case .failure:
                completion(false, nil)

            case .success(let data):

                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue

                if result_code == PARAMS.CODE_SUCESS {
                    let userInfo = dict[PARAMS.USERINFO]
                    completion(true, userInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
    
    class func fogotPWD(email : String, completion : @escaping (_ success: Bool, _ response : Any?) -> ()) {

        let URL = API_USER + FORGOT
        let params = [PARAMS.EMAIL : email] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {

            case .failure:
                completion(false, nil)

            case .success(let data):

                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue

                if result_code == PARAMS.CODE_SUCESS {
                    let userInfo = dict[PARAMS.VERIFY_CODE]
                    completion(true, userInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
    class func verifyCode(email : String, verifyCode: String, completion : @escaping (_ success: Bool, _ response : Any?) -> ()) {

        let URL = API_USER + VERIFY_CODE
        let params = [
            PARAMS.EMAIL : email,
            PARAMS.VERIFY_CODE : verifyCode,
            ] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {

            case .failure:
                completion(false, nil)

            case .success(let data):

                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue

                if result_code == PARAMS.CODE_SUCESS {
                    let userInfo = dict[PARAMS.USER_ID].stringValue
                    completion(true, userInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
    class func changePWD(userId : String, pwd: String, completion : @escaping (_ success: Bool, _ response : Any?) -> ()) {

        let URL = API_USER + CHANGE_PWD
        let params = [
            PARAMS.USER_ID : userId,
            PARAMS.PASSWORD : pwd,
            ] as [String : Any]
        
        Alamofire.request(URL, method:.post, parameters:params).responseJSON { response in
            
            switch response.result {

            case .failure:
                completion(false, nil)

            case .success(let data):

                let dict = JSON(data)
                let result_code = dict[PARAMS.RESULT_MSG].stringValue

                if result_code == PARAMS.CODE_SUCESS {
                    let userInfo = dict[PARAMS.USERINFO]
                    completion(true, userInfo)
                } else {
                    completion(false, result_code)
                }
            }
        }
    }
    
}
