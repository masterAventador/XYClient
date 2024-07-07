//
//  Screen.swift
//  CommonViewModule
//
//  Created by Aventador on 2024/6/29.
//

public struct Screen {
    
    public static let width = CGRectGetWidth(UIScreen.main.bounds)
    
    public static let height = CGRectGetHeight(UIScreen.main.bounds)
    
    public static let centerX = CGRectGetMidX(UIScreen.main.bounds)
    
    public static let centerY = CGRectGetMidY(UIScreen.main.bounds)
    
    public static let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    
    public static let keyWindow = {
        if #available(iOS 15.0, *), let windowScene{
            return windowScene.keyWindow
        }
        return UIApplication.shared.keyWindow
    }()
    
    public static let navigationBarHeight = statusBarHeight + 44
    
    public static let statusBarHeight = {
        if #available(iOS 13.0, *),
           let windowScene, let statusBarManager = windowScene.statusBarManager
        {
            return statusBarManager.statusBarFrame.height
        }
        
        return UIApplication.shared.statusBarFrame.height
    }()
    
    public static let bottomSafeArea = {
        if #available(iOS 15.0, *),
           let windowScene, let keyWindow = windowScene.keyWindow {
            return keyWindow.safeAreaInsets.bottom
        }
        
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }()
}
