//
//  AppDelegate.swift
//  Themes
//
//  Created by Jeff Norton on 1/3/17.
//  Copyright © 2017 JeffCryst. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //==================================================
    // MARK: - Methods
    //==================================================

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Retrieve the stored theme and apply it
        guard let storedTheme = ThemeManager.currentTheme() else {
            NSLog("Error identifying the stored theme.")
            return false
        }
        
        ThemeManager.applyTheme(storedTheme)
        
        return true
    }
}

