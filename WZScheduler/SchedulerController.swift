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
    
    var horizontalPagedView = UIScrollView()
    
    func nextDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: currentDate)!
    }
    func previousDate()->Date{
        return Calendar.current.date(byAdding: Calendar.Component.day, value: -1, to: currentDate)!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
