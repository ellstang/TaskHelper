//
//  RegisterViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

  @IBOutlet weak var userNameTextFd: UITextField!
  @IBOutlet weak var emailTextFd: UITextField!
  @IBOutlet weak var passwordTextFd: UITextField!
  @IBOutlet weak var registerBtn: UIButton!
  
  let userdefaults = UserDefaults.standard
//  var ref: DatabaseReference!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let blankTextFdObserver = UITapGestureRecognizer(target: self, action: #selector(checkIfAllInfoIsFilled))
//    registerBtn.addGestureRecognizer(blankTextFdObserver)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func register(_ sender: UIButton) {
    if checkIfAllInfoIsFilled() {
      register()
    } else {
      let alert = alertVC(title: "Hey", alertMsg: "請輸入完整帳號資料喔", alertOpt: "okayyy")
      self.present(alert, animated: true, completion: nil)
    }
  }
  

  @objc func checkIfAllInfoIsFilled() -> Bool {
    
    guard userNameTextFd.text != "" else {
      userNameTextFd.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      userNameTextFd.layer.borderWidth = 1
      return false
    }
    
    guard emailTextFd.text != "" else {
      emailTextFd.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      emailTextFd.layer.borderWidth = 1
      return false
    }
    
    guard passwordTextFd.text != "" else{
      passwordTextFd.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      passwordTextFd.layer.borderWidth = 1
      return false
    }
    return true
    
  }
  
  func register() {
    let name = userNameTextFd.text!
    let email = emailTextFd.text!
    let password = passwordTextFd.text!
    
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      if error != nil {
        let errorContent = error?.localizedDescription
        if errorContent != nil {
          let alert = self.alertVC(title: errorContent!, alertMsg: "an error occured", alertOpt: "okay")
          self.present(alert, animated: true, completion: nil)
          }
        return
        }
       else {
        print("Account created!")
        let displayName = self.userNameTextFd.text
        self.userdefaults.set(displayName, forKey: "userName")
        
        // important modification: set user Id in DB same as user uid in Auth
        guard let  uid = Auth.auth().currentUser?.uid else { return }
        let userInfoDict = ["name": name, "email": email, "password": password,"sentTasks": [""], "fetchedTasks": [""]] as NSDictionary
        Database.database().reference(withPath: "user").child("\(uid)").setValue(userInfoDict)
        let alert = UIAlertController(title: "Congrats", message: "成功創建新帳號", preferredStyle: .alert)
        let alertAct = UIAlertAction(title: "Cool", style: .default, handler: { (done) in
//          let storyboard = UIStoryboard(name: "Main", bundle: nil)
//          let sendTaskVC = storyboard.instantiateViewController(withIdentifier: "SendTaskVC")
//          self.present(sendTaskVC, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(alertAct)
        self.present(alert, animated: true, completion: nil)
        
//          //register currentUserAutoID into userdefaults for later calling this user to store sent tasks or fetched tasks
//          let currentUserUid = ref.key
      }
    }
  }
  
  func alertVC(title: String, alertMsg: String, alertOpt: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: alertMsg, preferredStyle: .alert)
    let alertMsg = UIAlertAction(title: alertOpt, style: .default, handler: nil)
    alert.addAction(alertMsg)
    return alert
  }
  
  // MARK: - touches began method
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    emailTextFd.resignFirstResponder()
    passwordTextFd.resignFirstResponder()
    userNameTextFd.resignFirstResponder()
  }
}
