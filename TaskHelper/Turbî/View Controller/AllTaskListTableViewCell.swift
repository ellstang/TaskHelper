//
//  AllMissionListTableViewCell.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.
//

import UIKit

class AllTaskListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cellContentView: UIView!
  @IBOutlet weak var taskSenderPic: UIImageView!
  @IBOutlet weak var taskTitle: UILabel!
  @IBOutlet weak var taslContent: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.contentView.layer.cornerRadius = self.contentView.frame.size.height/6
    self.contentView.clipsToBounds = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    cellContentView.frame = UIEdgeInsetsInsetRect(cellContentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
