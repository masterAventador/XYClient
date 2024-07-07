//
//  UIColor.swift
//  Alamofire
//
//  Created by Aventador on 2024/6/27.
//

import Foundation

extension UIColor {
    convenience init(_ hex:Int, a:CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
