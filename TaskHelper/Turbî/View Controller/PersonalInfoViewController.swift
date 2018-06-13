//  PersonalInfoViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit

class PersonalInfoViewController: UIViewController {
  
  @IBOutlet weak var userInfoPic: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInfoPic.layer.cornerRadius = userInfoPic.frame.size.height/2
    userInfoPic.clipsToBounds = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
