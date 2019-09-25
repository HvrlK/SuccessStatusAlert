//
//  AppDelegate.swift
//  Examples
//
//  Created by Vitalii Havryliuk on 25.09.2019.
//

import UIKit
import SuccessStatusAlert

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureSuccessStatusAlert()
        return true
    }
    
    func configureSuccessStatusAlert() {
        SuccessStatusAlert.appearance().tintColor = .systemGreen
        SuccessStatusAlert.appearance().contentBackgroundColor = .black
        SuccessStatusAlert.appearance().titleColor = .systemGray
        if #available(iOS 13.0, *) {
            SuccessStatusAlert.appearance().visualEffect = UIBlurEffect(style: .systemMaterial)
            SuccessStatusAlert.appearance().descriptionColor = .systemGray2
        } else {
            SuccessStatusAlert.appearance().visualEffect = UIBlurEffect(style: .regular)
            SuccessStatusAlert.appearance().descriptionColor = UIColor.systemGray.withAlphaComponent(0.8)
        }
    }

}

