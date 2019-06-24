//
//  AppDelegate.swift
//  ONRadar
//
//  Created by Davide Santo on 24.06.19.
//  Copyright © 2019 Davide Santo. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //to locate where Realm will store data
        print("Realm DB address: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        
        do{
            _ = try Realm()
           
        } catch {
            print("Error initialising  Realm DB \(error)")
        }
        
        
        return true
    }

}

