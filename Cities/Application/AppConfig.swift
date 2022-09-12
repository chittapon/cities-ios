//
//  AppConfig.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import Foundation

protocol AppConfigProtocol {
    var baseURL: URL { get }
}

struct AppConfig  {
    
    static let shared: AppConfigProtocol = {
        return Develop()
    }()
    
    struct Develop: AppConfigProtocol {
        let baseURL = URL(string: "https://raw.githubusercontent.com")!
    }
    
}
