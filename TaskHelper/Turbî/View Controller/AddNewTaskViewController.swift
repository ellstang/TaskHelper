//  AddNewTaskViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import Firebase

class AddNewTaskViewController: UIViewController {
  
  // MARK: -outlet sets
  @IBOutlet weak var taskTitleTextFd: UITextField!
  @IBOutlet weak var taskContentTextFd: UITextField!
  @IBOutlet weak var taskRewardTextFd: UITextField!
  @IBOutlet weak var timeLimitationTextFd: UITextField!
  @IBOutlet weak var sendTaskBtn: UIButton!
  @IBOutlet weak var cancelBtn: UIButton!
  
  // MARK: - properties
  let taskSentDate = Date()
  let dateFormatter = DateFormatter()
  
  // MARK: - declare the plist path for sent task id
  //make the sender's auto Id as name of file path

  var sentTaskIdSet = [String]()
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sendTaskBtn.layer.cornerRadius = self.sendTaskBtn.frame.height/2
    sendTaskBtn.clipsToBounds = true
    cancelBtn.layer.cornerRadius = self.cancelBtn.frame.height/2
    cancelBtn.clipsToBounds = true
  }
  
  // MARK: - viewWillAppear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    sendTaskBtn.isEnabled = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func cancel(_ sender: UIButton) {
    clearTextFd()
  }
  
  @IBAction func sendTask(_ sender: UIButton) {
    if checkIfLoggedIn() {
      if checkIfTextFdIsFilled() {
        sendTask()
        clearTextFd()
        presentDoneSendingTaskView()
      }
    }
  }
  
  // MARK: - check if each textFd is filled
  func checkIfTextFdIsFilled() -> Bool {
    if taskTitleTextFd.text == "" || taskContentTextFd.text == "" || taskRewardTextFd.text == "" || timeLimitationTextFd.text == "" {
      let alert = alertVC(title: "Ohoh", alertMsg: "請輸入完整任務內容喔", alertOpt: "okayyy")
      self.present(alert, animated: true, completion: nil)
      return false
    } else {
      return true
    }
  }
  
  // MARK: - get task send time:
  func getTaskSentTime() -> String {
    let unformattedTaskSentTime = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy/MM/dd/ HH:mm"
    let formattedTaskSentTime = timeFormatter.string(from: unformattedTaskSentTime)
    
    return formattedTaskSentTime
  }
  
  func sendTask() {
    var taskIdKey = ""
    //var updateSenderWithTaskID = ["sentTasks": [""]]
    var sentTasks = [String]()
    guard let sender = Auth.auth().currentUser?.uid, sender != nil else { return }
    
    let taskTitle = taskTitleTextFd.text
    let taskContent = taskContentTextFd.text
    let timeLimitation = timeLimitationTextFd.text!
    let reward = taskRewardTextFd.text
    let taskSentTime = getTaskSentTime()
    let thisTask = ["taskID": "", "sender": sender , "taskTitle": taskTitle!, "taskContent": taskContent!, "taskSentTime": taskSentTime, "timeLimitation": timeLimitation, "taskReward": reward!, "fetcherID": "", "completed": false] as [String : Any]
    
    //retrieve task id for previously sent tasks
    Database.database().reference(withPath: "user").child("\(sender)").child("sentTasks").observe(.value) { (previousTaskId) in
      // casting snapshot value to array of string
      let previousTaskIdValue = previousTaskId.value as? Array<String> ?? []
      print(previousTaskIdValue)
      // assign previously sent tasks to sentTasks
      sentTasks = previousTaskIdValue
    }
    //get task id for this sending task
    Database.database().reference(withPath: "Tasks").childByAutoId().setValue(thisTask) { (err, ref) in
      taskIdKey = ref.key
      if err != nil {
        let errMsg = err?.localizedDescription
        print(errMsg!)
        return
      }
      //appending this task Id into array
      sentTasks.append(taskIdKey)
      Database.database().reference().child("user/\(sender)/sentTasks").setValue(sentTasks)
    }
  }
  
  // MARK: - define save taskId method
//  func saveTaskId() {
//    let encoder = PropertyListEncoder()
//    do {
//      let data = try encoder.encode(sentTaskIdSet)
//      try data.write(to: taskIDFilePath!)
//    } catch {
//      print("saving error \(error)")
//    }
//  }
//  func loadTaskId() {
//    if let data = try? Data(contentsOf: taskIDFilePath!) {
//      do {
//        let decoder = PropertyListDecoder()
//        sentTaskIdSet = try decoder.decode([String].self, from: data)
//      } catch {
//        print("decode error \(error)")
//      }
//    }
//  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? MyTasksViewController else {
      return
    }
    destination.sentTaskIdArray = sentTaskIdSet
    print(destination.sentTaskIdArray)
  }
  
  // MARK: - check if logged in method:
  func checkIfLoggedIn() -> Bool {
    if Auth.auth().currentUser?.uid == nil {
      sendTaskBtn.isEnabled = false
      let alert = UIAlertController(title: "ohoh", message: "You need to log in", preferredStyle: .alert)
      let alertAct = UIAlertAction(title: "okayyy", style: .cancel) { (action) in
        self.performSegue(withIdentifier: "goStartingVC", sender: nil)
      }
      alert.addAction(alertAct)
      self.present(alert, animated: true, completion: nil)
      return false
    }
    return true
  }
  
  // MARK: - touches began
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    taskTitleTextFd.resignFirstResponder()
    taskRewardTextFd.resignFirstResponder()
    taskContentTextFd.resignFirstResponder()
    timeLimitationTextFd.resignFirstResponder()
  }
  
  // MARK: - create alertVC:
  func alertVC(title: String, alertMsg: String, alertOpt: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: alertMsg, preferredStyle: .alert)
    let alertMsg = UIAlertAction(title: alertOpt, style: .default, handler: nil)
    alert.addAction(alertMsg)
    return alert
  }
  
  // MARK: - empty all text field metohd
  func clearTextFd() {
    taskTitleTextFd.text = ""
    taskRewardTextFd.text = ""
    taskContentTextFd.text = ""
    timeLimitationTextFd.text = ""
  }
  
  // MARK: - present done sending task view
  func presentDoneSendingTaskView() {
    let aView: UIView = {
      let view = UIView()
      view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      view.backgroundColor = .gray
      
      return view
    }()
    let textLabel: UILabel = {
      let label = UILabel()
      label.frame = CGRect(x: (self.view.frame.width/2)-80, y: (self.view.frame.height/2+5)-(label.frame.height/2), width: 160, height: 40)
      label.text = "任務送出，功德圓滿"
//      label.font = UIFont(name: "華康體", size: 20)
      
      return label
    }()
    
    let checkMarkView: UIImageView = {
      let imageView = UIImageView()
      imageView.frame = CGRect(x: (self.view.frame.width/2), y: (self.view.frame.height/2), width: 0, height: 0)
      imageView.contentMode = .scaleAspectFit
      imageView.image = UIImage(named: "勾勾")
      imageView.layer.cornerRadius = imageView.frame.height/2
      imageView.clipsToBounds = true
      
      return imageView
    }()
    self.view.addSubview(aView)
    aView.addSubview(checkMarkView)
    aView.addSubview(textLabel)
    
    UIView.animate(withDuration: 1, animations: {
      checkMarkView.frame = CGRect(x: (self.view.frame.width/2)-25, y: (self.view.frame.height/2)-25, width: 50, height: 50)
      checkMarkView.contentMode = .scaleAspectFit
      checkMarkView.image = UIImage(named: "勾勾")
      checkMarkView.layer.cornerRadius = checkMarkView.frame.height/2
      checkMarkView.clipsToBounds = true
    }) { (true) in
      UIView.animate(withDuration: 1) {
        UIView.animate(withDuration: 0.6, animations: {
          checkMarkView.frame = CGRect(x: (self.view.frame.width/2), y: (self.view.frame.height/2), width: 0, height: 0)
          aView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height)
          textLabel.removeFromSuperview()

          textLabel.frame = CGRect(x: (self.view.frame.width/2)-80, y: (self.view.frame.height/2+5)-(textLabel.frame.height/2), width: 0, height: 40)
        }, completion: { (true) in
          checkMarkView.removeFromSuperview()
          aView.removeFromSuperview()
        })
      }
    }
    
  }
}
