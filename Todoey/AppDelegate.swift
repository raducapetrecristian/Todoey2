//
//  AppDelegate.swift
//  Todoey
//
//  Created by Cristi Raduca on 25/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //The Realm database file path ->
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do{
            _ = try Realm()
        }
        catch{
            print("Error initialising realm \(error)")
        }
        
        return true
    }
}

