//
//  ViewController.swift
//  LoginVerfier
//
//  Created by Voltmeter Amperage on 7/29/16.
//  Copyright © 2016 Gabriel Revells. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginManager = GCRSwiftlyLogin()
        
        loginManager.passwordRequirements = [.RequireNumber]
        loginManager.password = "gabe1"
        loginManager.email = "skoobie94@gmail.com"
        
        loginManager.saveToKeychain()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

