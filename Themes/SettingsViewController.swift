//
//  SettingsViewController.swift
//  Themes
//
//  Created by Jeff Norton on 1/3/17.
//  Copyright © 2017 JeffCryst. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //==================================================
    // MARK: - _Properties
    //==================================================
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func themeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if let newTheme = Theme(rawValue: sender.selectedSegmentIndex) {
            ThemeManager.applyTheme(newTheme)
            
            /*
             Manually update the Navigation bar to modify this in-place.  ThemeManager.applyTheme() will
             take care of changing all future views.
             */
            self.navigationController?.navigationBar
                .barStyle = (ThemeManager.currentTheme()?.barStyle)!
            self.navigationController?.navigationBar
                .setBackgroundImage(newTheme.navigationBackgroundImage, for: .default)
            
            /*
             Manually update the UITabBar
             */
            self.tabBarController?.tabBar
                .barStyle = newTheme.barStyle
            self.tabBarController?.tabBar
                .backgroundImage = newTheme.tabBarBackgroundImage
        }
    }
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the Navigation Bar's title image
        let titleImageView = UIImageView(image: UIImage(named: "test-text-image"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        // Select the stored theme value in the Segmented Control
        guard let currentTheme = ThemeManager.currentTheme() else {
            NSLog("Error getting the current theme's raw value for selecting the Theme Segmented Control's selected index.")
            return
        }
        themeSegmentedControl.selectedSegmentIndex = currentTheme.rawValue
    }
}
