//
//  MainViewController.swift
//  XYClient
//
//  Created by Aventador on 2024/6/6.
//

import UIKit
import BaseViewModule
import HTTPModule
import SwiftProtobuf

class MainViewController: XYViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        let register = PHM_Register.with {
            $0.account = "123123123"
            $0.pwd = "33333"
        }
        
        Http.post(.register, payload: register, responseType: PHM_RegisterResp.self) { response in
            switch response {
            case .success(let value):
                print(value)
            case .failure(let aferror):
                print(aferror)
            }
        }
        
//        let login = PHM_Login.with {
//            $0.account = "我我 我我我"
//            $0.pwdMd5 = "dddddddddd"
//        }
//        Http.post(.login, payload: login, responseType: PHM_LoginResp.self) { response in
//            switch response {
//            case .success(let value):
//                print(value)
//            case .failure(let aferror):
//                print(aferror)
//            }
//        }
    }
}
