//
//  CustomClass.swift
//  Nukadshoppee
//
//  Created by APPLE MAC MINI on 16/01/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    func showAlert(title: String , message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIImageView{
    func setImageborder(colorValue: UIColor,widthValue: CGFloat,cornerRadiusValue : CGFloat) {
        
        self.layer.borderColor = colorValue.cgColor
        self.layer.borderWidth = widthValue
        self.layer.cornerRadius = cornerRadiusValue
        self.clipsToBounds = true
    }
    
    func removeImageborder()
    {
        self.layer.borderWidth = 0.0
        self.clipsToBounds = true
    }
    
}

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -5), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

func isValidPhoneNumber(value: String) -> Bool {
    //let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    
    let PHONE_REGEX = "^\\d{10}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}
func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
