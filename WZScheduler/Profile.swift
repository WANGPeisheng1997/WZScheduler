//
//  Profile.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/24.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import Foundation

public class Account {
    
    var username: String?
    var db_id: NSNumber?
    var data: [[String:Any]]?
    
    init(){
    }
    
    init(username: String, db_id: NSNumber) {
        self.username = username
        self.db_id = db_id
    }
}
