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
        case .graphical, .normal:
            return .default
        case .dark:
            return .black
        }
    }
    
    /* Consumers
        *UIApplication delegate window's tint color
        *UISwitch colors
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
    
    /* Consumers
     *UINavigation appearance's background image
     */
    var navigationBackgroundImage: UIImage? {
        return self == .graphical ? UIImage(named: "wave_w414h92x1") : nil
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
    // MARK: - Properties
    //==================================================
    
    static var tabBarController: UITabBarController?
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func applyTheme(_ theme: Theme) {
        // Save the Theme value in UserDefaults and write the changes
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // Change the tint color
        UIApplication.shared.delegate?.window??.tintColor = theme.mainColor
        
        // Set the Navigation Bar's bar style and background image
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        
        // Customize the Navigation Bar's back indicator
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        // Set the Tab Bar's bar style
        if let tabBarController = tabBarController {
            tabBarController.tabBar.barStyle = theme.barStyle
            tabBarController.tabBar.backgroundImage = theme.tabBarBackgroundImage
            
            // Customize the tab bar's selection indicator
            let tabBarSelectionIndicatorLine = UIImage().createTabBarSelectionIndicatorLine(color: theme.mainColor
                , size: CGSize(width: (tabBarController.tabBar.frame.width) / CGFloat(tabBarController.tabBar.items!.count)
                    , height: (tabBarController.tabBar.frame.height))
                , lineWidth: 3.0)
            tabBarController.tabBar.selectionIndicatorImage = tabBarSelectionIndicatorLine
        }
        
        // Customize the segmented control
        let controlBackgroundRegular = UIImage(named: "controlBackgroundRegular")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        let controlBackgroundSelected = UIImage(named: "controlBackgroundSelected")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0))
        
        UISegmentedControl.appearance().setBackgroundImage(controlBackgroundRegular, for: .normal, barMetrics: .default)
        UISegmentedControl.appearance().setBackgroundImage(controlBackgroundSelected, for: .selected, barMetrics: .default)
        
        // Customize the stepper
        let controlBackground = UIImage(named: "controlBackground")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
        
        UIStepper.appearance().setDecrementImage(UIImage(named: "sunOne_s18x1"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "sunThree_s18x1"), for: .normal)
        
        // Customize the slider
        UISlider.appearance().setThumbImage(UIImage(named: "seashell_pt30x1"), for: .normal)
        UISlider.appearance()
            .setMinimumTrackImage(UIImage(named: "minimumTrack")?
                .withRenderingMode(.alwaysTemplate)
                .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 6.0, bottom: 0.0, right: 0.0)), for: .normal)
        UISlider.appearance()
            .setMaximumTrackImage(UIImage(named: "maximumTrack")?
                .resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 6.0, bottom: 0.0, right: 6.0)), for: .normal)
        
        // Customize the switch
        UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainColor
    }
    
    static func currentTheme() -> Theme? {
        // Retrieve the theme value from UserDefaults.  If it succeeds create a new Theme instance.  If it doesn't then return the normal theme.
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            guard let theme = Theme(rawValue: storedTheme) else {
                return nil
            }
            
            return theme
            
        } else {
            return .normal
        }
    }
}

extension UIImage {
    func createTabBarSelectionIndicatorLine(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
