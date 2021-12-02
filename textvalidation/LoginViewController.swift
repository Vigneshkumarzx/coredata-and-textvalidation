//
//  LoginViewController.swift
//  textvalidation
//
//  Created by vignesh kumar c on 24/11/21.
//

import UIKit
import CoreData


class LoginViewController: UIViewController {
    
    
    var container: NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    
    var Loginusers:[SignupMo]?
      
    @IBOutlet var LoginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
  
      
    }
    
    @IBAction func Tapped(_ sender: UIButton) {
    
        let fetchAll = NSFetchRequest<NSFetchRequestResult>(entityName: "Signup")

        fetchAll.fetchLimit = 1
        fetchAll.predicate = NSPredicate(format: "username = %@ AND password = %@",NameField.text!,PassField.text!)
        Loginusers = try? container.viewContext.fetch(fetchAll) as? [SignupMo]

        if self.Loginusers?.count != 0 {
            let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
            let vc2 = storyboard2.instantiateViewController(withIdentifier: "LoggedInViewControllerid")
            self.navigationController?.pushViewController(vc2, animated: true)
        } else {
            print("Invalid Credentials")
        }

    }
}
