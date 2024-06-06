//
//  MainViewController.swift
//  XYClient
//
//  Created by Aventador on 2024/6/6.
//

import UIKit
import BaseViewModule
import HTTPModule

class MainViewController: XYViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        Http.post(Http_LoginReq(), responseType: Http_LoginResp.self) { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
