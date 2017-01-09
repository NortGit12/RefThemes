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
     *UIApplication delegate window's tint color
     */
    var mainColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 242/255.0, green: 101/255.0, blue: 34/255.0, alpha: 1.0)  // orange
        case .graphical:
            return UIColor(red: 10/255.0, green: 10/255.0, blue: 10/255.0, alpha: 1.0)    // black
        case .normal:
            return UIColor(red: 87/255.0, green: 188/255.0, blue: 95/255.0, alpha: 1.0)   // light green
        }
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
        UIApplication.shared.delegate?.window??.tintColor = theme.mainColor
        
        // Customize the segmented control
        let controlBackgroundRegular = UIImage(named: "controlBackgroundRegular")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        let controlBackgroundSelected = UIImage(named: "controlBackgroundSelected")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        
        UISegmentedControl.appearance().setBackgroundImage(controlBackgroundRegular, for: .normal, barMetrics: .default)
        UISegmentedControl.appearance().setBackgroundImage(controlBackgroundSelected, for: .selected, barMetrics: .default)
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
