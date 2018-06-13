//
//  LogInViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/6.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
  
  // MARK: - UIbutton outlet
  @IBOutlet weak var emailTextFd: UITextField!
  @IBOutlet weak var psdTextFd: UITextField!
  @IBOutlet weak var logInBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logInBtn.layer.cornerRadius = self.logInBtn.frame.height/2
    logInBtn.clipsToBounds = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
  @IBAction func cancel(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func logIn(_ sender: UIButton) {
    guard let email = emailTextFd.text, let psd = psdTextFd.text else {
      return
    }
    Auth.auth().signIn(withEmail: email, password: psd) { (user, err) in
      if err != nil {
        let errMsg = err!
        let logInErrAlert = self.createAlert(title: "ohoh", alertMsg: "\(errMsg)", alertAct: "ok")
        self.present(logInErrAlert, animated: true, completion: nil)
        return 
      }
      //no error, log user in:
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC")
      self.present(mainVC, animated: true, completion: nil)
    }
  }
  
  // MARK: - touches began method
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    emailTextFd.resignFirstResponder()
    psdTextFd.resignFirstResponder()
  }
  
  // MARK: - create alert method:
  func createAlert(title: String?, alertMsg: String?, alertAct: String?) -> UIAlertController{
    let alert = UIAlertController(title: title, message: alertMsg, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: alertAct, style: .cancel, handler: nil)
    alert.addAction(alertAction)
    return alert
  }
}
