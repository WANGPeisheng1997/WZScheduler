//
//  Mission.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/20.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit

class MissionView:UIView {
    
    var missionID = 0
    var missionName = "empty_mission_name"
    var startTime = 0
    var endTime = 0
    
    var missionNameLabel = UILabel()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 450, height: 450))
    }
    
    init(mission:Mission){
        super.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        missionID = mission.work_id
        missionName = mission.name
        startTime = mission.start_time
        endTime = mission.end_time
        
        self.backgroundColor = UIColor.blue
        
        missionNameLabel.text = missionName
        missionNameLabel.textAlignment = NSTextAlignment.center
        self.addSubview(missionNameLabel)
    }
    
    func setFrame(frame:CGRect){
        self.frame = frame
        self.missionNameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Mission {
    
    var db_id = "1"
    var work_id = 1
    var name = "睡觉"
    var parent_id = 1
    var type = "REPEAT"
    var repeat_by = "WEEK"
    var repeat_days = [0,1,2,3,6]
    var any_time = false
    var start_time = 0
    var end_time = 27000
    var duration = 0
    var deadline = 0
    var check_time = [0]
    
    //let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
   
    func load(dict: Dictionary<String, Any>){
        db_id = dict["db_id"] as! String
        work_id = dict["work_id"] as! Int
        name = dict["name"] as! String
        parent_id = dict["parent_id"] as! Int
        type = dict["type"] as! String
        repeat_by = dict["repeat_by"] as! String
        repeat_days = dict["repeat_days"] as! [Int]
        any_time = dict["any_time"] as! Bool
        start_time = dict["start_time"] as! Int
        end_time = dict["end_time"] as! Int
        duration = dict["duration"] as! Int
        deadline = dict["deadline"] as! Int
        check_time = dict["check_time"] as! [Int]
        //print(work_id, "   ", name, "   ",db_id)
    }
}
