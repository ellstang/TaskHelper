//  TaskModel.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/7.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import Foundation

class Task {
  var taskID: String?
  var sender: AnyObject?
  var senderDisplayName: AnyObject?
  var fetcherID: String?
  
  var taskTitle = ""
  var taskContent = ""
  
  var timeLimitation: AnyObject
  var taskIssuedDate: String?
  var taskReward: AnyObject?
  
  var completed = false
  init(taskID: String?, sender: AnyObject?, senderDisplayName: AnyObject?,taskTitle: String, taskContent: String, timeLimitation: AnyObject, taskIssuedDate: String,taskReward: AnyObject?, fetcherID: String?) {
    self.taskID = taskID
    self.sender = sender
    self.senderDisplayName = senderDisplayName
    self.taskTitle = taskTitle
    self.taskContent = taskContent
    self.timeLimitation = timeLimitation
    self.taskIssuedDate = taskIssuedDate
    self.taskReward = taskReward
    self.fetcherID = fetcherID
  }

}


var allIssuedTasks = [Task]()
