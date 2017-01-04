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
    // MARK: - Actions
    //==================================================
    
    @IBAction func themeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if let newThemeValue = Theme(rawValue: sender.selectedSegmentIndex) {
            NSLog("newThemeValue = \(newThemeValue)")
            ThemeManager.applyTheme(newThemeValue)
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
    }
}
