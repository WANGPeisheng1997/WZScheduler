//
//  Mission.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/20.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit

class Mission:UIView {
    
    var missionType = 0
    var missionName = "empty_mission_name"
    
    var startTime = 0
    var endTime = 0
    
    var missionNameLabel = UILabel()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 450, height: 450))
    }
    
    init(missionType:Int, missionName:String, startTime:Int, endTime:Int){
        super.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        self.missionType = missionType
        self.missionName = missionName
        self.startTime = startTime
        self.endTime = endTime
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
