//
//  OneViewController.swift
//  Themes
//
//  Created by Jeff Norton on 1/3/17.
//  Copyright © 2017 JeffCryst. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    //==================================================
    // MARK: - _Properties
    //==================================================
    
    @IBOutlet weak var counterLabel: UILabel!
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func counterValueChanged(_ sender: UIStepper) {
        counterLabel.text = "\(Int(sender.value))"
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
