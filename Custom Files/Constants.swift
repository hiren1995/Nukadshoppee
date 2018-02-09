//
//  Constants.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 16/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import Foundation
import UIKit

//defaults
var udefault = UserDefaults.standard

//URL
let BaseURL = "https://bulale.in/nukadshoppee/index.php/api/"

//API
let LoginAPI = "\(BaseURL)/user/login"
let SendOTPAPI = "\(BaseURL)/user/send_otp_register"
let VerifyOTPAPI = "\(BaseURL)/user/otp_mobile_verify"
let StateListAPI = "\(BaseURL)/user/send_state_list"
let CityListAPI = "\(BaseURL)/user/send_city_list"
let ReligionListAPI = "\(BaseURL)/user/get_religion_list"
let UserDetailsAPI = "\(BaseURL)/user/first_login"
let GetWalletBalanceAPI = "\(BaseURL)/user/available_wallet_balance"
let GETTansactionDetailsAPI = "\(BaseURL)/user/get_transaction_details"
let GetDailyOffersAPI = "\(BaseURL)/user/get_daily_offers"


//Strings for user defaults

let rupee = "\u{20B9}"

var isLogin = "isLogin"
var MobileNumber = "MobileNumber"
var isDetails = "isDetails"
var UserId = "UserId"
var UserToken = "UserToken"
var DeviceId = "DeviceId"
var DeviceToken = "DeviceToken"
var CityName = "CityName"
var CityId = "CityId"
var StateName = "StateName"
var StateId = "StateId"
var ReligionName = "ReligionName"
var ReligionID = "ReligionID"
var LoginMobile = "LoginMobile"
var LoginPassword = "LoginPassword"



