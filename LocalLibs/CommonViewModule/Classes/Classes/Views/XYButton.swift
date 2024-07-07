//
//  XYButton.swift
//  CommonViewModule
//
//  Created by Aventador on 2024/7/1.
//

import UIKit

open class XYButton: UIButton {
    public struct SizeType {
        var size: CGSize
        
        public static var large: SizeType {
            return SizeType(size: CGSizeMake(300, 200))
        }
        
        public static var middle: SizeType {
            return SizeType(size: CGSizeMake(200, 100))
        }
        
        public static var small: SizeType {
            return SizeType(size: CGSizeMake(100, 50))
        }
    }
    
    open var sizeType: SizeType = SizeType.middle
    
    public convenience init(_ sizeType: SizeType = .middle) {
        self.init(type: .custom)
        self.sizeType = sizeType
        titleLabel?.font = CommonFont.boldButton
        backgroundColor = CommonColor.main
        layer.cornerRadius = 8
    }
    
    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? CommonColor.main : CommonColor.disableMain
        }
    }
    
}
