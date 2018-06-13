//  MyTasks.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/13.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import Foundation

struct MyFetchedTaskArray {
  static let shared = MyFetchedTaskArray()
  var fetchedTaskIds = [String?]()

  private init() {}

  mutating func appendTaskId(taskId Id: String) -> [String?] {
    self.fetchedTaskIds.append(Id)
    return self.fetchedTaskIds
  }
}

struct MySentTasksArray {
  static let shared = MySentTasksArray()
  var sentTaskIds = [String?]()
  private init() {}

  mutating func appendTaskId(taskId Id: String) -> [String?] {
    self.sentTaskIds.append(Id)
    return self.sentTaskIds
  }
}

//class MyFetchedTaskArray {
//  var fetchedTaskId = [String]()
//}

//class MySentTasksArray {
//  var sentTaskId = [String]()
//}
