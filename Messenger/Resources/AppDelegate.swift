//
//  AppDelegate.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import Firebase

// Swift
//
// AppDelegate.swift
import UIKit
//import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
          
//        UIApplication.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        FirebaseApp.configure()

        return true
    }
          
//    func application(
//        _ app: UIApplication,
//        open url: URL,
//        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//    ) -> Bool {
////
////        UIApplication.shared.application(
////            app,
////            open: url,
////            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
////            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
////        )
//    }
    
}

    
