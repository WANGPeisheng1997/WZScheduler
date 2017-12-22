//
//  SchedulerScrollView.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/22.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit

class SchedulerScrollView:UIScrollView{
    
    //var newMission = MissionView()
    var timeAxisLabel = [UILabel]()
    var missionViewArray = [MissionView]()
    let distance = 40
    let baseTime = 0 * 3600
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSize(width: self.frame.width, height: CGFloat(24*distance))
        self.contentOffset.y = calculateOffset(Tag: 0)
        
        initializeTimeAxisLabel(baseTime: baseTime)
        
    }
    
    /*
    func createMissionList(missionName:String){
        missionList = []
        missionList.append(addNewMission(missionType: 0, missionName: missionName, startTime: 6, endTime: 9))
    }
    */
    func calculateTimeAxisLabelPosition(Tag:Int)->CGRect{
        return CGRect(x:0, y:distance*Tag, width:60, height:distance)
    }
    
    func calculateOffset(Tag:Int)->CGFloat{
        return min(CGFloat(distance*Tag), CGFloat(24*distance)-self.frame.height)
    }
    
    /*
     @objc func swipeLeft(_ recognizer:UISwipeGestureRecognizer){
     print("swipe ok")
     refresh(direction: 1)
     }
     
     @objc func swipeRight(_ recognizer:UISwipeGestureRecognizer){
     print("swipe ok")
     refresh(direction: 2)
     }
     */
    
    /*
    func refresh(direction:Int){
        for i in missionList {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {i.alpha = 0.0}, completion: {
                (finished:Bool) -> Void in
                i.removeFromSuperview()
                self.contentOffset.y = self.calculateOffset(Tag: 0)
            })
        }
        missionList = []
        if(direction == 1) {
            missionList.append(addNewMission(missionType: 0, missionName: "阿阿", startTime: 11, endTime: 17))
        }
        else{
            missionList.append(addNewMission(missionType: 0, missionName: "哼", startTime: 9, endTime: 22))
        }
    }
 */
    
    func loadMission(missionList: [Mission]){
        for mission in missionList {
            let newMissionView = MissionView(mission: mission)
            newMissionView.setFrame(frame: CGRect(x: 70, y: distance*(mission.start_time-baseTime)/3600+20, width: 230, height: distance*(mission.end_time-mission.start_time)/3600))
            missionViewArray.append(newMissionView)
            self.addSubview(newMissionView)
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress(_:)))
            
            longPressRecognizer.minimumPressDuration = 1.0
            newMissionView.isUserInteractionEnabled = true
            newMissionView.addGestureRecognizer(longPressRecognizer)
        }
    }
    
    func clearMission(){
        for oldMissionView in missionViewArray {
            oldMissionView.removeFromSuperview()
        }
        missionViewArray = []
    }
    
    // 手势响应方法
    @objc func longPress(_ recognizer:UILongPressGestureRecognizer){
        
        if recognizer.state == .began {
            let alertView = UIAlertView(title: nil, message: "长按响应", delegate: nil, cancelButtonTitle: "知道了")
            alertView.show()
        }
    }
    
    func initializeTimeAxisLabel(baseTime:Int){
        for i in 0...23{
            let newLabel = UILabel()
            newLabel.text = String((i+baseTime)%24) + ":00"
            newLabel.frame = calculateTimeAxisLabelPosition(Tag: i)
            //newLabel.textAlignment = NSTextAlignment.center
            self.addSubview(newLabel)
            timeAxisLabel.append(newLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
