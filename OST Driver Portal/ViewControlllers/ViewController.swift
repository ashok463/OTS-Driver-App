//
//  ViewController.swift
//  OST Driver Portal
//
//  Created by Gulfam Khan on 17/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionNext(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardNames.Registration, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

