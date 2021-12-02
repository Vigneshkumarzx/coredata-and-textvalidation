//
//  ViewController.swift
//  textvalidation
//
//  Created by vignesh kumar c on 19/11/21.
//

import UIKit
import CoreData

class SignupMo: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var confirmpassword: String
    
}

class ViewController: UIViewController, UITextFieldDelegate,UIApplicationDelegate {

    var container: NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer
    }
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var ConfirmField: UITextField!
    @IBOutlet weak var lblalertMes: UILabel!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var age: UITextField!
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblalertMes.text = ""
        phoneNum.delegate = self
        userName.delegate = self
        self.datePicker.maximumDate = Date()
        createDatepicker()
        resignFirstResponder()
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == phoneNum {
            let allowedCharacters = "1234567890"
            return allowedCharacters.contains(string)
        }else if textField == userName {
            let allowedCharacters = "1234567890"
            return !allowedCharacters.contains(string)
        }
        else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createDatepicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        dateOfBirth.inputAccessoryView = toolbar
        dateOfBirth.inputView = datePicker
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let birthdayDate = datePicker.date
        dateOfBirth.text = formatter.string(from: birthdayDate)
        let cal = Calendar.current
        self.view.endEditing(true)
    }
    
    @IBAction func signedup(_ sender: Any) {
       

        lblalertMes.text = ""
        guard let Name = userName.text, Name != "" else {
            lblalertMes.text = "Please Enter valid name"
            return
        }
        guard let email = emailField.text, email != "" else {
            lblalertMes.text = "Please Enter valid email"
            return
        }
        guard let password = passwordField.text, password != "" else {
            lblalertMes.text = "Please Enter valid password"
            return
        }
        guard let Repassword = ConfirmField.text, Repassword != "", Repassword == password else {
            lblalertMes.text = "Password did not matched"
            return
        }
        
        let signedup = NSEntityDescription.insertNewObject(forEntityName: "Signup", into: container.viewContext) as? SignupMo
        signedup?.username = userName.text!
        signedup?.password = passwordField.text!
        signedup?.email = emailField.text!
        signedup?.confirmpassword = ConfirmField.text!
        do {
           try container.viewContext.save()
        } catch {
            print(error)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        self.dismiss(animated: true, completion: nil)
        
        
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard1.instantiateViewController(withIdentifier: "SignedUpViewControllerid")
        self.navigationController?.pushViewController(vc1, animated: true)
        
    }
    
}
