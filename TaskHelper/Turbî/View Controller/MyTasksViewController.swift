//  MyTasksViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit

class MyTasksViewController: UIViewController {
  
  var sentTaskIdArray = [String]()
  
  @IBOutlet weak var TaskConditionsView: UIView!
  @IBOutlet weak var taskContentTextFd: UITextView!
  
  @IBOutlet weak var confirmTaskBtn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    confirmTaskBtn.layer.cornerRadius = 12
    TaskConditionsView.layer.cornerRadius = 12
    TaskConditionsView.clipsToBounds = true
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func confirmDoneTask(_ sender: UIButton) {
  }
}
