//
//  AppDelegate.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 16/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,MessagingDelegate{

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.statusBarBackgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1.0)
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        
        return true
    }
    
    //--------------------------------------- Push Notification module Start ---------------------------------------------------------------------------------------------------
    
    
    //To get Device Token or Firebase Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        // FCM Token
        if let refreshedToken = InstanceID.instanceID().token(){
            print("InstanceID token: \(refreshedToken)")
            
            let device_id = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
            print("The device Token is = \(device_id)")
            
            udefault.set(refreshedToken, forKey: DeviceToken)
            udefault.set(device_id, forKey: DeviceId)
            
            self.Authenicate()
            
        }
        connectToFcm()
        
    }
    
    func connectToFcm() {
        Messaging.messaging().connect{ (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
                
            } else {
                print("Connected to FCM.")
                //self.Authenicate()
            }
        }
    }
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String)
    {
        print("Firebase registration token: \(fcmToken)")
        
        udefault.set(fcmToken, forKey: DeviceToken)
        udefault.set("123456", forKey: DeviceId)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        print(JSON(userInfo))
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Print full message.
        print(JSON(userInfo))
        
    }
    
    
    //Called if unable to register for APNS.
    private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    
    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
        
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    
    //--------------------------------------- Push Notification module End ---------------------------------------------------------------------------------------------------
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func Authenicate()
    {
        let login = UserDefaults.standard.bool(forKey: isLogin)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if login{
            
            let loginParameters:Parameters = ["app_user_contact_number": udefault.value(forKey: LoginMobile) as! String , "app_user_password" : udefault.value(forKey: LoginPassword) as! String ,"app_user_device_id" : udefault.value(forKey: DeviceId) as! String, "app_user_device_token" : udefault.value(forKey:  DeviceToken) as! String]
            
            print(loginParameters)
            
            Alamofire.request(LoginAPI, method: .post, parameters: loginParameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                if(response.result.value != nil)
                {
                    
                    print(JSON(response.result.value))
                    
                    let tempDict = JSON(response.result.value!)
                    
                    if(tempDict["status_code"].intValue == 1)
                    {
                        
                        udefault.set(true, forKey: isLogin)
                        udefault.set(true, forKey: isEmailVerified)
                        UserData = tempDict["user_info"][0]
                        TaxData = tempDict["tax_info"][0]
                        
                        udefault.set(UserData["app_user_token"].stringValue, forKey: UserToken)
                        udefault.set(UserData["app_user_id"].intValue, forKey: UserId)
                        
                        udefault.set(UserData["state_id"].intValue, forKey: StateId)
                        udefault.set(UserData["state_name"].stringValue, forKey: StateName)
                        
                        udefault.set(UserData["app_user_city"].intValue, forKey: CityId)
                        udefault.set(UserData["city_name"].stringValue, forKey: CityName)
                        
                        udefault.set(UserData["app_user_religion"].intValue, forKey: ReligionID)
                        udefault.set(UserData["religion_name"].stringValue, forKey: ReligionName)
                        
                        //print(UserData)
                        //print(TaxData)
                        
                    }
                    else if(tempDict["status_code"].intValue == 3)
                    {
                        udefault.set(true, forKey: isLogin)
                        udefault.set(false, forKey: isEmailVerified)
                        
                        
                        UserData = tempDict["user_data"][0]
                        TaxData = tempDict["tax_info"][0]
                        
                        udefault.set(UserData["app_user_token"].stringValue, forKey: UserToken)
                        udefault.set(UserData["app_user_id"].intValue, forKey: UserId)
                        
                        udefault.set(UserData["state_id"].intValue, forKey: StateId)
                        udefault.set(UserData["state_name"].stringValue, forKey: StateName)
                        
                        udefault.set(UserData["app_user_city"].intValue, forKey: CityId)
                        udefault.set(UserData["city_name"].stringValue, forKey: CityName)
                        
                        udefault.set(UserData["app_user_religion"].intValue, forKey: ReligionID)
                        udefault.set(UserData["religion_name"].stringValue, forKey: ReligionName)
                        
                        
                    }
                    else
                    {
                        let initialView = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
                        self.window?.rootViewController = initialView
                    }
                }
                else
                {
                    self.window?.rootViewController?.showAlert(title: "Alert", message: "Please Check Your Internet Connection")
                }
            })
        }
        else
        {
            let initialView = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignIn
            self.window?.rootViewController = initialView
        }
        
        
    }
}

