//
//  CalendarVC.swift
//  xfit
//
//  Created by Dev1 on 3/12/16.
//  Copyright © 2016 fxofficeapp. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CalendarWeekViewControllerDelegate {

    var weekView: CalendarWeekViewControllerView?
    var selectedIndex = -1
    var results = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view, typically from a nib.
        weekView = CalendarWeekViewControllerView(frame: CGRectMake(16, 130, view.frame.width, 44))
        view.addSubview(weekView!)
        
        let calendarMenu = CalendarMenuView(frame: CGRectMake(4, 82, view.frame.width - 4, 22))
        view.addSubview(calendarMenu)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        weekView?.delegate = self
        
        self.parseData()

    }
    
    func daySelect() {
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesInRange: range)
        self.tableView.reloadSections(sections, withRowAnimation: .Left)
    }
    
    func nextWeekView() {}
    func prevWeekView(){}
    func afterAutoScroll(){}
    
//    func scrollToPrevDay(sender: UITapGestureRecognizer) {
//        print("prev")
//        weekView!.scrollToPrevDay()
//    }
//    
//    func scrollToNextDay(sender: UITapGestureRecognizer) {
//        print("next")
//        weekView!.scrollToNextDay()
//    }
        
        
        @IBOutlet weak var tableView: UITableView!
        
        override func viewWillAppear(animated: Bool) {
            self.navigationController?.navigationBarHidden = true
            self.evo_drawerController?.openDrawerGestureModeMask = .All
        }
        
        var schedule = [Schedule]()
        var preventAnimation = Set<NSIndexPath>()
    
        
        func parseData() {
            
            
            let objects = [[
                    "title":"HEART-X",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"БАССЕЙН",
                    "time":"07:30",
                    "duration":"45 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй.",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"PILATES MAT",
                    "content":"Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"10:00",
                    "duration":"55 МИН."
                ],[
                    "title":"САМОДЕЛКИ",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ДЕТ.СТУДИЯ",
                    "time":"11:00",
                    "duration":"30 МИН."
                ],[
                    "title":"X-PUMP",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"11:30",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ],[
                    "title":"LOW CORE",
                    "content":"Доказано: занятия в воде отлично тренируют весь организм. Однако мы разработали программу, которая акцентирует нагрузки на, пожалуй, главный орган нашего тела – сердце. Регулярно посещая HEART-X, вы почувствуете, насколько легче стало переносить повседневные нагрузки. Тренировка проходит со  специальным оборудованием (пояса, перчатки)",
                    "place":"ЗАЛ 1",
                    "time":"09:00",
                    "duration":"55 МИН."
                ]]
            
            for object in objects {
                
                let schedule = Schedule(dictionary: object)
                
                self.schedule.append(schedule)
                
            }
            
            
            self.tableView.reloadData()
        }
        
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return schedule.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let schedule = self.schedule[indexPath.row]
            
            if let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell {
                
                cell.configureCell(schedule)
                
                return cell
                
            } else {
                return ScheduleCell()
            }
            
        }
        
        func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            if !preventAnimation.contains(indexPath) {
                preventAnimation.insert(indexPath)
                cell.alpha = 0
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    cell.alpha = 1
                })
            }
        }
        
        func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return tableView.rowHeight
        }

    
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if selectedIndex == indexPath.row {
                return UITableViewAutomaticDimension
            } else {
                return 58
            }
        }
    
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            if selectedIndex == indexPath.row {
                selectedIndex = -1
                tableView.beginUpdates()
                tableView.endUpdates()
            } else
            
            if selectedIndex != -1 {
                selectedIndex = indexPath.row
                tableView.beginUpdates()
                tableView.endUpdates()
            } else {
            
                selectedIndex = indexPath.row
                tableView.beginUpdates()
                tableView.endUpdates()
            
            }
        }
    
        
        @IBAction func openMenu(sender: AnyObject) {
            self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
            
        }
        
        @IBAction func openProfile(sender: AnyObject) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        
}



