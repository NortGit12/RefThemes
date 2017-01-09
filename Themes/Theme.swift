//
//  Theme.swift
//  Themes
//
//  Created by Jeff Norton on 1/4/17.
//  Copyright © 2017 JeffCryst. All rights reserved.
//

import UIKit

let SelectedThemeKey = "SelectedTheme"

enum Theme: Int {
    
    //==================================================
    // MARK: - Cases
    //==================================================
    
    case dark, graphical, normal
    
    //==================================================
    // MARK: - Computed Properties
    //==================================================
    
    /* Consumers
     *UINavigation appearance's bar style
     */
    var barStyle: UIBarStyle {
        switch self {
        case .normal, .graphical:
            return .default
        case .dark:
            return .black
        }
    }
    
    /*
     Consumers:
     *UIApplication delegate window's tint color
     */
    var mainColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 87/255.0, green: 188/255.0, blue: 95/255.0, alpha: 1.0)   // light green 
        case .dark:
            return UIColor(red: 242/255.0, green: 101/255.0, blue: 34/255.0, alpha: 1.0)  // orange
        case .graphical:
            return UIColor(red: 10/255.0, green: 10/255.0, blue: 10/255.0, alpha: 1.0)    // black 
        }
    }
    
    /*
     Consumers:
     *UINavigation appearance's background image
     */
    var navigationBackgroundImage: UIImage? {
        return self == .graphical ? UIImage(named: "navBarBackground") : nil
    }
    
    /*
     Consumers:
     *UITabBar appearance's background image
     */
     var tabBarBackgroundImage: UIImage? {
        return self == .graphical ? UIImage(named: "tabBarBackground") : nil
    }
}

struct ThemeManager {
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func applyTheme(_ theme: Theme) {
        // Save the Theme value in UserDefaults and write the changes
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // Change the tint color
        let shared = UIApplication.shared
        shared.delegate?.window??.tintColor = theme.mainColor
        
        // Set the Navigation Bar's bar style
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        
        // Customize the Navigation Bar's back indicator
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        // Set the Tab Bar's bar style
        // This is handled in the Theme Segmented Control's value changed method because it has access to the current tabBarController
    }
    
    static func currentTheme() -> Theme? {
        // Retrieve the theme value from UserDefaults.  If it succeeds create a new Theme instance.  If it doesn't then return the normal theme.
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            guard let theme = Theme(rawValue: storedTheme) else {
                NSLog("Error creating a Theme from the stored Theme value.")
                return nil
            }
            
            return theme
            
        } else {
            return .normal
        }
    }
}
