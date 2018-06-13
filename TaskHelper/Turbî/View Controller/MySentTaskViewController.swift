//
//  SecondViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
//import UserNotifications

class MySentTaskViewController: UIViewController {
  enum taskType: Int {
    case mySentTask
    case myFetchedTask
  }

  //var index2:IndexPath?
  let userdefault = UserDefaults.standard
  var sentTaskIDs = [String]()
  var sentTasks = [Task]()
  
  @IBOutlet weak var myTasksTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(Auth.auth().currentUser?.uid)
    getMyFetchedTasksId { (finished) in
      if finished == true {
        self.myTasksTableView.reloadData()
        //self.pushNotif()
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //pushNotif()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

extension MySentTaskViewController: UITableViewDelegate, UITableViewDataSource {
  // MARK: - configure section headers
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 2
//  }
//  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//    return ["我發的任務","接的任務"]
//  }

  // MARK: - configure tableView cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sentTaskIDs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTaskListTableViewCell
    let thisTaskID = sentTaskIDs[indexPath.row]
    
    if thisTaskID != "" {
      Database.database().reference().child("Tasks/\(thisTaskID)").observe(.value) { (snapshot) in
        var task: Task!
        let thisTask = snapshot.value as? [String: AnyObject] ?? [:]
        let ifcompleted = thisTask["completed"] as AnyObject
        let fetcherID = thisTask["fetcherID"] as! AnyObject
        let sender = thisTask["sender"] as AnyObject
        let senderDisplayName = thisTask["senderDisplayName"] as AnyObject
        let taskTitle = thisTask["taskTitle"] as! String
        let taskContent = thisTask["taskContent"] as! String
        let timeLimitation = thisTask["timeLimitation"] as AnyObject
        let taskIssuedDate = thisTask["taskSentTime"] as! String
        let taskReward = thisTask["taskReward"] as AnyObject
        task = Task(taskID: self.sentTaskIDs[indexPath.row], sender: sender, senderDisplayName: senderDisplayName, taskTitle: taskTitle, taskContent: taskContent, timeLimitation: timeLimitation, taskIssuedDate: taskIssuedDate, taskReward: taskReward, fetcherID: "\(fetcherID)")
        print(task)
        DispatchQueue.main.async {
          cell.taskTitle.text = task.taskTitle
          cell.taskContent.text = task.taskContent
          if task.fetcherID != "" {
            cell.taskSenderPic.image = UIImage(named: "勾勾")
            cell.taskTitle.text = "任務進行中"
          } else {
            cell.taskSenderPic.image = UIImage(named: "smile")
          }
        }
      }
    }
    return cell
  }
  
  // MARK: - fetched tasks id
  //改成可以 escaping 的函式，讓去資料庫抓取 task ID 的任務完成之後，才去執行下面的任務
  func getMyFetchedTasksId(completion: @escaping (Bool) -> ()) {
    // get rid of optional type of uid
    guard let uid = Auth.auth().currentUser?.uid else { return }

    Database.database().reference(fromURL: "https://fir-createaccount-874c8.firebaseio.com/user/\(uid)/sentTasks").observe(.value) { (snapshot) in
      let array = snapshot.value as? Array<String> ?? [String]()
      self.sentTaskIDs = array
      print(self.sentTaskIDs)
      completion(true)
    }
  }
  
  // MARK: - create notification when user task is fetched:
 // func pushNotif() {
    //check if the user had sent any tasks
 //   guard sentTaskIDs.count > 0 else { return }
 ///   print("for")
    //    for i in 0...sentTaskIDs.count-1 {
////      Database.database().reference().observeValue(forKeyPath: <#T##String?#>, of: <#T##Any?#>, change: <#T##[NSKeyValueChangeKey : Any]?#>, context: <#T##UnsafeMutableRawPointer?#>)
//      Database.database().reference(fromURL: "https://fir-createaccount-874c8.firebaseio.com/Tasks/\(sentTaskIDs[i])/fetcherID").observe(.childAdded) { (snapshot) in
//        print(snapshot.value)
 //       if snapshot.value != nil {
//          let content = UNMutableNotificationContent()
//          content.title = NSString.localizedUserNotificationString(forKey: "Helper!", arguments: nil)
//          content.body = NSString.localizedUserNotificationString(forKey: "您的任務已被接走", arguments: nil)
//          content.sound = UNNotificationSound.default()
//          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//          let request = UNNotificationRequest(identifier: "taskFetchedNotif", content: content, trigger: trigger)
//          UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
//            if error != nil {
//              print("Notify error: ", error!)
//            } else {
//            }
//          })
 //       }
 //     }
 //   }
 // }
  
  func getMyTaskContentsFromDB(indexPath row: Int){
    var task: Task!
    Database.database().reference(fromURL: "Tasks/\(sentTaskIDs[row])").observe(.value) { (snapshot) in
      let thisTask = snapshot.value as? [String: AnyObject] ?? [:]
      let ifcompleted = thisTask["completed"] as AnyObject
      let fetcherID = thisTask["fetcherID"] as! String
      let sender = thisTask["sender"] as AnyObject
      let senderDisplayName = thisTask["senderDisplayName"] as AnyObject
      let taskTitle = thisTask["taskTitle"] as! String
      let taskContent = thisTask["taskContent"] as! String
      let timeLimitation = thisTask["timeLimitation"] as AnyObject
      let taskIssuedDate = thisTask["taskIssuedDate"] as! String
      let taskReward = thisTask["taskReward"] as AnyObject
      
      task = Task(taskID: self.sentTaskIDs[row], sender: sender, senderDisplayName: senderDisplayName, taskTitle: taskTitle, taskContent: taskContent, timeLimitation: timeLimitation, taskIssuedDate: taskIssuedDate, taskReward: taskReward, fetcherID: fetcherID)
    }
  }
  

}
