//
//  MyTaskListTableViewCell.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit

class MyTaskListTableViewCell: UITableViewCell {
  @IBOutlet weak var myTasksBackgoundView: UIView!
  @IBOutlet weak var taskSenderPic: UIImageView!
  @IBOutlet weak var taskTitle: UILabel!
  @IBOutlet weak var taskContent: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
   let bgViewWidth = self.myTasksBackgoundView.frame.size.height
    self.myTasksBackgoundView.layer.cornerRadius = bgViewWidth/8
    self.myTasksBackgoundView.clipsToBounds = true

  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
