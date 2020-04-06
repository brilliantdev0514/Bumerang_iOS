//
//  ApiConstant.swift
//  bumerang
//
//  Created by RMS on 2019/9/14.
//  Copyright © 2019 RMS. All rights reserved.
//

import Foundation

//let HOST = "http://192.168.0.10:3001/"
let HOST = "http://178.157.15.79:3001/"


//user apis
let API_USER = HOST + "user/"

let SIGNUP = "signup"
let LOGIN  = "login"
let FORGOT = "forgotPassword"
let VERIFY_CODE       = "verifyCode"
let CHANGE_PWD        = "changePassword"
let UPDATE_USERINFO   = "updateUserInfo"
let UPDATE_MEMBERSHIP = "updateMembership"

// product of cataory apis
let API_PRODUCT = HOST + "product/"
let UPLOAD_PRODUCT = "uploadProduct"
let GET_ALL_PRODUCT = "getCatProducts"

//rent product
let API_RENT = HOST + "rentalProduct/"
let REQUEST_RENT_PRODUCT = "requestRental"
let GET_RENT_HISTORY_USER = "getUserHistory"
let GET_RENT_HISTORY_OWNER = "getOwnerHistory"

struct PARAMS {
    
    static let CODE_SUCESS = "Success"
    

    static let DEVICE_TOKEN = "device_token"
    //respons content
    // signup
    static let FIRSTNAME = "first_name"
    static let LASTNAME = "last_name"
    static let EMAIL = "email"
    static let PASSWORD = "pwd"
    static let USER_TYPE = "user_type"
    static let AUTH_TYPE = "auth_type"
    static let LOCATION_LAT = "lat"
    static let LOCATION_LNG = "lng"
    
    //verifyCode
    static let VERIFY_CODE = "verify_code"
    
    
    //upload product
    static let CATAGORY_ID = "category"
    static let OWNER_ID = "owner_id"
    static let TITLE = "title"
    static let ROOM_NUMBER = "room_number"
    static let HEATING = "heating"
    static let FURBISHED = "furbished"
    static let FUEL_TYPE = "fuel_type"
    static let GEAR_TYPE = "gear_type"
    static let DOOR_NUMBER = "door_number"
    static let CAR_TYPE = "car_type"
    static let BED_CAPACITY = "bed_capacity"
    static let PERSON_CAPACITY = "person_capacity"
    static let CAPTAN = "captan"
    static let GENDER = "gender"
    static let SIZE = "size"
    static let COLOR = "color"
    static let PRICE_VAL = "price"
    static let PRICE_TYPE = "date_unit"
    static let DEPOSIT = "deposit"
    static let DESCRIPTION = "description"
    static let UPLOAD_IMAGE = "images"
    static let ADDRESS = "address"
    static let ZIP_CODE = "zip_code"
    
    //get product list of one catagory
    static let PAGE_NUM = "page_number"
    
    //rent product
    static let USER_ID    = "user_id"
    static let PRODUCT_ID = "product_id"
    static let START_DATE = "start_date"
    static let END_DATE   = "end_date"
    static let USER_MSG   = "users_message"
    static let RENT_PRICE = "rental_price"
    static let SERVICE_FEE = "service_fee"
    
    
    
    //request content
    // signup
    static let RESULT_MSG = "msg"
    static let USERINFO = "user_info"
    static let UPLOADINFO = "upload_info"
    static let PRODUCTLIST_CATAOGRY = "all_products"
    
    
}
