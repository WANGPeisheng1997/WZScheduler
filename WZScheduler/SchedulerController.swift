//
//  SchedulerController.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/20.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit

class SchedulerController: UIViewController {
    
    var newMission = Mission()
    var timeAxisLabel = [UILabel]()
    let distance = 40
    let baseTime = 6
    
    var missionList = [Mission]()
    
    @IBOutlet weak var mainView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeTimeAxisLabel(baseTime: baseTime)
        
        //mainView.frame = self.view.bounds
        mainView.contentSize = CGSize(width: mainView.frame.width, height: CGFloat(24*distance))
        mainView.contentOffset.y = calculateOffset(Tag: 7)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(swipeLeft(_:)))
        swipeLeftRecognizer.direction = .left
        let swipeRightRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(swipeRight(_:)))
        swipeRightRecognizer.direction = .right
        mainView.addGestureRecognizer(swipeLeftRecognizer)
        mainView.addGestureRecognizer(swipeRightRecognizer)
        
        missionList.append(addNewMission(missionType: 0, missionName: "睡觉", startTime: 6, endTime: 9))
        missionList.append(addNewMission(missionType: 0, missionName: "上课", startTime: 10, endTime: 12))
        missionList.append(addNewMission(missionType: 0, missionName: "学习", startTime: 15, endTime: 18))
        missionList.append(addNewMission(missionType: 0, missionName: "玩耍", startTime: 19, endTime: 22))
        //self.view.addSubview(mainView)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(direction:Int){
        for i in missionList {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {i.alpha = 0.0}, completion: {
                (finished:Bool) -> Void in
                i.removeFromSuperview()
                self.mainView.contentOffset.y = self.calculateOffset(Tag: 0)
            })
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationDuration(2)
//            i.alpha = 0.0
//            i.removeFromSuperview()
//            UIView.commitAnimations()
        }
        missionList = []
        if(direction == 1) {
            missionList.append(addNewMission(missionType: 0, missionName: "阿阿", startTime: 11, endTime: 17))
        }
        else{
            missionList.append(addNewMission(missionType: 0, missionName: "哼", startTime: 9, endTime: 22))
        }
    }
    
    func initializeTimeAxisLabel(baseTime:Int){
        for i in 0...23{
            let newLabel = UILabel()
            newLabel.text = String((i+baseTime)%24) + ":00"
            newLabel.frame = calculateTimeAxisLabelPosition(Tag: i)
            //newLabel.textAlignment = NSTextAlignment.center
            mainView.addSubview(newLabel)
            timeAxisLabel.append(newLabel)
        }
    }
    
    func calculateTimeAxisLabelPosition(Tag:Int)->CGRect{
        return CGRect(x:0, y:distance*Tag, width:60, height:distance)
    }
    
    func calculateOffset(Tag:Int)->CGFloat{
        return min(CGFloat(distance*Tag), CGFloat(24*distance)-mainView.frame.height)
    }
    
    // 手势响应方法
    @objc func longPress(_ recognizer:UILongPressGestureRecognizer){
        
        if recognizer.state == .began {
            let alertView = UIAlertView(title: nil, message: "长按响应", delegate: nil, cancelButtonTitle: "知道了")
            alertView.show()
        }
    }
    
    @objc func swipeLeft(_ recognizer:UISwipeGestureRecognizer){
        print("swipe ok")
        refresh(direction: 1)
    }
    
    @objc func swipeRight(_ recognizer:UISwipeGestureRecognizer){
        print("swipe ok")
        refresh(direction: 2)
    }
    
    func addNewMission(missionType: Int, missionName: String, startTime: Int, endTime: Int)->Mission{
        newMission = Mission(missionType: missionType, missionName:missionName, startTime:startTime, endTime:endTime)
        newMission.setFrame(frame: CGRect(x: 70, y: 40*(startTime-baseTime)+20, width: 230, height: 40*(endTime-startTime)))
        newMission.backgroundColor = UIColor.blue
        newMission.alpha = 0.0
        mainView.addSubview(newMission)
        
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {self.newMission.alpha = 1.0}, completion: {(finished:Bool) -> Void in})
        
        var longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress(_:)))

        longPressRecognizer.minimumPressDuration = 1.0
        newMission.isUserInteractionEnabled = true
        newMission.addGestureRecognizer(longPressRecognizer)
        return newMission
    }
    
    
}
