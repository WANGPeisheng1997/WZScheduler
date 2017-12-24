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
    
    var previousMissionList = [Mission]()
    var todayMissionList = [Mission]()
    var nextMissionList = [Mission]()
    
    var horizontalPagedView = UIScrollView()
    
    func nextDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: currentDate)!
    }
    func previousDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: -1, to: currentDate)!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.clear
        //self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        
        download()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func download(){
        let url = URL(string: "http://115.159.59.44:5000/update")!
        var request = URLRequest(url: url)
        let params:NSMutableDictionary = NSMutableDictionary()
        params["kind"] = "update"
        //params["username"] = account.username
        params["username"] = "WPS"
        //params["db_id"] = account.db_id
        params["db_id"] = 105601592
        params["update_time"] = 0
        params["data"] = "{}"
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonData:NSData? = nil
        do {
            jsonData  = try JSONSerialization.data(withJSONObject: params, options:JSONSerialization.WritingOptions.prettyPrinted) as NSData?
        } catch {
            
        }
        request.httpBody = jsonData as Data?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = response, let data = data {
                //print(response)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                /*
                 do {
                 json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.init(rawValue:0))
                 } catch {
                 
                 }
                 */
                let dictionary = json as? [String: Any]
                let dictdata = dictionary?["data"] as? [[String:Any]]
                
                account.data = dictionary?["data"] as? [[String:Any]]
                print(account.data)
                
                self.initialize()
                
            } else {
                print(error!)
            }
        }
        
        task.resume()
    }
    
    func initialize(){
        
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
        
        refreshMissionList()
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
        refreshMissionList()
    }
    
    func refreshMissionList(){
        previousView.clearMission()
        mainView.clearMission()
        nextView.clearMission()
        previousMissionList = []
        todayMissionList = []
        nextMissionList = []
        
        for json in account.data! {
            let newMission = Mission()
            newMission.load(dict: json)
            if(newMission.isToday(today: oneDayBeginningTime(date: previousDate()))){
                self.previousMissionList.append(newMission)
            }
            if(newMission.isToday(today: oneDayBeginningTime(date: currentDate))){
                self.todayMissionList.append(newMission)
            }
            if(newMission.isToday(today: oneDayBeginningTime(date: nextDate()))){
                self.nextMissionList.append(newMission)
            }
        }
        previousView.loadMission(missionList: previousMissionList)
        mainView.loadMission(missionList: todayMissionList)
        nextView.loadMission(missionList: nextMissionList)
    }
    
    func oneDayBeginningTime(date: Date)->Date{
        let todayBeginningTime = dateFormatter.string(from: date)
        let todayBeginning = dateFormatter.date(from: todayBeginningTime)!
        return todayBeginning
    }
}
