//  TaskDetailViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/8.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class TaskDetailViewController: UIViewController {
  var data: Task?
  let userdefualt = UserDefaults.standard
  //var myFetchedTaskArray: MyFetchedTaskArray?
  
  @IBOutlet weak var taskTitle: UILabel!
  @IBOutlet weak var taskReward: UILabel!
  @IBOutlet weak var restTime: UILabel!
  @IBOutlet weak var taskContent: UILabel!
  @IBOutlet weak var fetchTaskBtn: UIButton!
  @IBOutlet weak var taskIssuedDateLabel: UILabel!
  
  let databaseRef = Database.database().reference(fromURL: "https://fir-createaccount-874c8.firebaseio.com/Tasks/")

  override func viewDidLoad() {
    super.viewDidLoad()
    taskReward.adjustsFontForContentSizeCategory  = true
    guard let reward = data?.taskReward!, reward != nil else {
      return
    }
    guard let timeRested = data?.timeLimitation, timeRested != nil else {
      return
    }
    guard let taskIssuedDate = data?.taskIssuedDate, taskIssuedDate != "" else {
      return
    }
    taskTitle.text = data?.taskTitle
    taskReward.text = "\(reward)"
    taskContent.text = data?.taskContent
    restTime.text = "\(timeRested)"
    taskIssuedDateLabel.text = "\(taskIssuedDate)"
    // check if this tasked is already fetched
    guard let fetcherId = data?.fetcherID!, fetcherId == "" else {
      fetchTaskBtn.isEnabled = false
      fetchTaskBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0.3058823529, alpha: 1)
      fetchTaskBtn.setTitle("任務已被接走", for: .disabled)
      return
    }
  
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func fetchTask(_ sender: UIButton) {
  
    guard let uid = Auth.auth().currentUser?.uid , uid != nil else {
      let alert = UIAlertController(title: "ohoh", message: "請登入才能接任務喔", preferredStyle: .alert)
      let alertAct = UIAlertAction(title: "好喔", style: .default) { (act) in
        
      }
      return
    }
    guard let taskId = self.data?.taskID else {
      return
    }
    
    let taskApiRef = "https://fir-createaccount-874c8.firebaseio.com/Tasks/\(taskId)"
    let apiRef = Database.database().reference(fromURL: "\(taskApiRef)")
    let updateTaskStatus = ["fetcherID": uid,"completed": false] as [String : Any]
    print(taskId)
    //let dropDashedTaskId = String(taskId.characters.dropFirst())
    apiRef.updateChildValues(updateTaskStatus)
    let alert = UIAlertController(title: "Cool", message: "接任務囉", preferredStyle: .alert)
    let alertAct = UIAlertAction(title: "hen 好", style: .default) { (act) in
      self.fetchTaskBtn.isEnabled = false
      self.fetchTaskBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0.3058823529, alpha: 1)
      self.fetchTaskBtn.setTitle("任務已被接走", for: .disabled)
    }
    alert.addAction(alertAct)
    self.present(alert, animated: true, completion: nil)
//    guard myFetchedTaskArray?.fetchedTaskId == [""] else {
//      return
//    }
    // unable to store id string into myFetchedTaskArray, dont know why
//    myFetchedTaskArray?.fetchedTaskId.append(taskId)
//    print(myFetchedTaskArray?.fetchedTaskId)
    //MyFetchedTaskArray.shared.appendTaskId(taskId: taskId)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? MySentTaskViewController else {
      return
    }
  }
  
  @IBAction func goBack(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
}
