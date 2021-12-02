//
//  HomePageViewController.swift
//  textvalidation
//
//  Created by vignesh kumar c on 24/11/21.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginBtntapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerid")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
