//
//  ViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/9/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var studentRoster = [Person]()
        var studentFirstNames    = ["Nate", "Matthew", "Jeff", "Chrstie", "David", "Adrian", "Jake", "Shams", "Cameron", "Kori", "Parker", "Nathan", "Casey", "Brendan", "Brian", "Mark", "Rowan", "Kevin", "Will", "Heather", "Tuan", "Zack", "Sara", "Hongyao"]
        var studentLastNames     = ["Birkholz", "Brightbill", "Chavez", "Ferderer", "Fry", "Gherle", "Hawken", "Kazi", "Klein", "Kolodziejczak", "Lewis", "Ma", "MacPhee", "McAleer", "Mendez", "Morris", "North", "Pham", "Richman", "Thueringer", "Vu", "Walkingstick", "Wong", "Zhang"]
        
        func buildRosterArray(first : [String], last : [String]) -> [Person] {
            
            var rosterPairs = [Person]()
            
            for var i = 0; i < first.count; i++ {
                
                rosterPairs.append(Person(firstName: (first[i]), lastName: (last[i])))
                
            }
            
            return(rosterPairs)
            
        }
        
        
        studentRoster = buildRosterArray(studentFirstNames, studentLastNames)
        
        for (var i = 0; i < studentRoster.count; i++) {
            
            println(studentRoster[i].fullName())
            
        }
        
        println(studentRoster[0].fullName())
        
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    



}