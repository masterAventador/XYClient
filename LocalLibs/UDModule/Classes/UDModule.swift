//
//  UDModule.swift
//  Alamofire
//
//  Created by Aventador on 2024/7/11.
//


import MMKV

public struct UDModule {
    
    static let storage = MMKV.default()!
    
    public static func addAccount(_ account:String,token:String) {
        storage.set(token, forKey: account)
    }
    
}
