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
        case .dark:
            return .black
        case .graphical:
            return .default
        case .normal:
            return .default
        }
    }
    
    /* Consumers
     *UINavigation appearance's background image
     */
    var navigationBackgroundImage: UIImage? {
        return self == .graphical ? UIImage(named: "navBarBackground") : nil
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
        
        // Set the Navigation Bar's bar style and background image
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
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
