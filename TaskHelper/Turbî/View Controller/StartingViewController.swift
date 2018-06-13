//
//  StartingViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/7.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    goLogInBtn.layer.borderColor =
      #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0.3098039216, alpha: 1)
    goLogInBtn.layer.borderWidth = 2.5
    goSignUpBtn.layer.cornerRadius = self.goSignUpBtn.frame.height/2
    goSignUpBtn.clipsToBounds = true
    goLogInBtn.layer.cornerRadius = self.goLogInBtn.frame.height/2
    goLogInBtn.clipsToBounds = true
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  // MARK: - IBAction set
  @IBAction func goSignUp(_ sender: UIButton) {
    self.performSegue(withIdentifier: "goSignUpVC", sender: nil)
  }
  
  @IBAction func goLogIn(_ sender: UIButton) {
    self.performSegue(withIdentifier: "goLogInVC", sender: nil)
  }
  
  // MARK: - IBOutlet set
  @IBOutlet weak var goSignUpBtn: UIButton!
  
  @IBOutlet weak var goLogInBtn: UIButton!
  

}
