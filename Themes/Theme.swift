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
}

struct ThemeManager {
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func applyTheme(_ theme: Theme) {
        // Save the Theme value in UserDefaults and write the changes
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // Customize the slider
        UISlider.appearance().setThumbImage(UIImage(named: "seashell_pt30x1"), for: .normal)
        UISlider.appearance()
            .setMinimumTrackImage(UIImage(named: "minimumTrack")?
                .withRenderingMode(.alwaysTemplate)
                .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 6.0, bottom: 0.0, right: 0.0)), for: .normal)
        UISlider.appearance()
            .setMaximumTrackImage(UIImage(named: "maximumTrack")?
                .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 6.0, bottom: 0.0, right: 6.0)), for: .normal)
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
