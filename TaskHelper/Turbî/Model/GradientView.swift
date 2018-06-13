//  GradientView.swift
//  Turbî
//
//  Created by 唐嘉伶 on 2018/5/5.
//  Copyright © 2018 唐嘉伶. All rights reserved.

//import Foundation
//import UIKit
//
//@IBDesignable
//class GradientView: UIView {
//  @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1) {
//    didSet {
//      self.setNeedsLayout()
//    }
//  }
//  @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1) {
//    didSet {
//      self.setNeedsLayout()
//    }
//  }
//  override func layoutSubviews() {
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [topColor, bottomColor]
//    gradientLayer.startPoint = CGPoint(x: 0, y: 0.2)
//    gradientLayer.endPoint = CGPoint(x: 1, y: 0.8)
//    gradientLayer.frame = self.bounds
//    self.layer.insertSublayer(gradientLayer, at: 0)
//  }
//  
//}
