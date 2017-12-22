//
//  SchedulerController.swift
//  WZScheduler
//
//  Created by 王沛晟 on 17/12/20.
//  Copyright © 2017年 王沛晟. All rights reserved.
//

import UIKit

class SchedulerController: UIViewController, UIScrollViewDelegate {
    
    let viewWidth = 343
    let viewHeight = 562
    
    var currentDate = Date()
    let dateFormatter = DateFormatter()
    
    let dateLabel = UILabel()

    var mainView = SchedulerScrollView()
    var previousView = SchedulerScrollView()
    var nextView = SchedulerScrollView()
    
    var todayMissionList = [Mission]()
    
    var horizontalPagedView = UIScrollView()
    
    var temp=0
    
    func nextDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: currentDate)!
    }
    func previousDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: -1, to: currentDate)!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let strHtml = try! NSString(contentsOf: NSURL(string: "http://115.159.59.44:5000/testdata")! as URL, encoding: String.Encoding.utf8.rawValue)
        print(strHtml)
        let data = strHtml.data(using: String.Encoding.utf8.rawValue)
        
        let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
        
        for json in jsonArr {
            temp = temp+1
            if(temp==1 || temp==4 || temp==9){
            let newMission = Mission()
            newMission.load(dict: json)
            todayMissionList.append(newMission)
            }
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
    
        dateLabel.text = dateFormatter.string(from: currentDate)
        dateLabel.frame = CGRect(x: 16,y: 28,width: viewWidth,height: 20)
        dateLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(dateLabel)
        
        horizontalPagedView.frame = CGRect(x: 16,y: 48,width: viewWidth,height: viewHeight)
        horizontalPagedView.contentSize = CGSize(width: viewWidth * 3,
                                        height: viewHeight)
        horizontalPagedView.isPagingEnabled = true
        horizontalPagedView.showsHorizontalScrollIndicator = false
        horizontalPagedView.showsVerticalScrollIndicator = false
        horizontalPagedView.scrollsToTop = false
        
        horizontalPagedView.addSubview(previousView)
        previousView.frame = CGRect(x: 0,y: 0,width: viewWidth,height: viewHeight)
        horizontalPagedView.addSubview(mainView)
        mainView.frame = CGRect(x: viewWidth,y: 0,width: viewWidth,height: viewHeight)
        horizontalPagedView.addSubview(nextView)
        nextView.frame = CGRect(x: viewWidth*2,y: 0,width: viewWidth,height: viewHeight)
        horizontalPagedView.contentOffset.x = CGFloat(viewWidth)
        
        horizontalPagedView.delegate = self
        self.view.addSubview(horizontalPagedView)
        
        mainView.loadMission(missionList: todayMissionList)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(horizontalPagedView.contentOffset.x == 0){
            currentDate = previousDate()
        }
        else if(horizontalPagedView.contentOffset.x == CGFloat(viewWidth * 2)){
            currentDate = nextDate()
        }
        
        dateLabel.text = dateFormatter.string(from: currentDate)
        
        horizontalPagedView.contentOffset.x = CGFloat(viewWidth)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
