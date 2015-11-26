//
//  ViewController.swift
//  Example
//
//  Created by Jeonglim So on 2015. 11. 24..
//  Copyright © 2015년 estmob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var progressBar:EMProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let progressBar = EMProgressBar()
        progressBar.trackTintColor = UIColor.blackColor()
        progressBar.progressTintColor = UIColor.whiteColor()
        progressBar.contentInset = UIEdgeInsetsMake(2, 2, 2, 2)
        progressBar.progress = 0.5
        self.view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        var newConstraints = [NSLayoutConstraint]()
        newConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[progressBar]-10-|", options: [], metrics: nil, views: ["progressBar":progressBar])
        newConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[progressBar(==24)]", options: [], metrics: nil, views: ["progressBar":progressBar])
        NSLayoutConstraint.activateConstraints(newConstraints)
    }

    @IBAction func onValueChanged(sender:UISlider) {
        progressBar.progress = sender.value
    }
}

