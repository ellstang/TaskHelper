//  UserModel.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/6.
//  Copyright © 2018 唐嘉伶. All rights reserved.

import Foundation

struct UserInfo {
  var displayname: String?
  var email: String?
  
  
}

struct User {
  var displayname: String?
  var email: String?
  var sentTasks: [String?]
  var fetchedTasks: [String?]
  
  init(displayname: String?, email: String?, sentTasks: [String?], fetchedTasks: [String?]) {
    self.displayname = displayname
    self.email = email
    self.sentTasks = sentTasks
    self.fetchedTasks = fetchedTasks
  }
}

