//  FirstViewController.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AllTasksViewController: UIViewController {
  var rowOfIndexpath: Int!
  
  @IBOutlet weak var allTasksTableView: UITableView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    //reloadUpadtedValue()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.allTasksTableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    
    self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0.3098039216, alpha: 1)
    self.navigationController?.navigationItem.title = "任務列表"
    self.navigationController?.navigationBar.tintColor = UIColor.black
    fetchIssuedTasks()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func fetchIssuedTasks() {
    let databaseRef = Database.database().reference(fromURL: "https://fir-createaccount-874c8.firebaseio.com/Tasks")
    databaseRef.observe(.childAdded) { (snapshot) in
      let taskDict = snapshot.value as? [String: AnyObject] ?? [:]
      let sender = taskDict["sender"] as! AnyObject
      let senderDisplayName = taskDict["senderDisplayName"] as! AnyObject
      let taskTitle = taskDict["taskTitle"] as! String
      let taskContent = taskDict["taskContent"] as! String
      let timeLimitation = taskDict["timeLimitation"] as! AnyObject
      let reward = taskDict["taskReward"] as! AnyObject
      let taskIssuedDate = taskDict["taskSentTime"] as! String
      //let fetcherdisplayname = taskDict["fetcher"]!["displayname"] as! String
      //let fetcherEmail = taskDict["fetcher"]!["email"] as! String
      let taskId = snapshot.key
      let fetcherID = taskDict["fetcherID"] as! String
      //這裡預設 fetcher 的 sentTasks 跟 fetchedTasks 為空字串，注意不要再把這兩個空字串洗回資料庫
 
      let task = Task(taskID: taskId, sender: sender, senderDisplayName: senderDisplayName, taskTitle: taskTitle, taskContent: taskContent, timeLimitation: timeLimitation, taskIssuedDate: taskIssuedDate, taskReward: reward, fetcherID: fetcherID)
      allIssuedTasks.append(task)
      print(allIssuedTasks.count)
      self.allTasksTableView.reloadData()
    }
  }
  
  func reloadUpadtedValue() {
    Database.database().reference(withPath: "Tasks").queryOrdered(byChild: "fetcherID").observe(.childChanged) { (snapshot) in
      //first empty the array that store all tasks
      allIssuedTasks = [Task]()
      //then pull down all the changed task contents again
      var task: Task!
      Database.database().reference().child("Tasks").observe(.childAdded, with: { (snapshot) in
        let taskDict = snapshot.value as? [String: AnyObject] ?? [:]
        let sender = taskDict["sender"] as! AnyObject
        let senderDisplayName = taskDict["senderDisplayName"] as! AnyObject
        let taskTitle = taskDict["taskTitle"] as! String
        let taskContent = taskDict["taskContent"] as! String
        let timeLimitation = taskDict["timeLimitation"] as! AnyObject
        let reward = taskDict["taskReward"] as! AnyObject
        let taskIssuedDate = taskDict["taskSentTime"] as! String
        let taskId = snapshot.key
        let fetcherID = taskDict["fetcherID"] as! String
        task = Task(taskID: taskId, sender: sender, senderDisplayName: senderDisplayName, taskTitle: taskTitle, taskContent: taskContent, timeLimitation: timeLimitation, taskIssuedDate: taskIssuedDate, taskReward: reward, fetcherID: fetcherID)
        allIssuedTasks.append(task)
        print(allIssuedTasks.count)
        self.allTasksTableView.reloadData()
        print("reloadUpadtedValue")
      })
      
    }
  }
  
  func emptyArray() {
    allIssuedTasks = [Task]()
  }
  
}

extension AllTasksViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allIssuedTasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! AllTaskListTableViewCell
    if allIssuedTasks[indexPath.row].fetcherID == "" {
      cell.taskSenderPic.image = UIImage(named: "smile")
      cell.taskTitle.text = allIssuedTasks[indexPath.row].taskTitle
      cell.taslContent.text = allIssuedTasks[indexPath.row].taskContent
    } else {
      cell.taskSenderPic.image = UIImage(named: "勾勾")
      cell.taskTitle.text = "任務進行中"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let destionationVC = segue.destination as? TaskDetailViewController {
//      print(rowOfIndexpath)
//      destionationVC.data = rowOfIndexpath
//    }
    guard let destination = segue.destination as? TaskDetailViewController else {
      fatalError("Error, destination view controller error.")
    }
    
    guard let indexPath = allTasksTableView.indexPathForSelectedRow else {
      return
    }
    
    destination.data = allIssuedTasks[indexPath.row]
    print(destination.data?.timeLimitation)
  }
  
 
}
