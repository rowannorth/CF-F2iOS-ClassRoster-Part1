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
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        var rowan = Person(firstName: "Rowan", lastName: "North")
        var sara = Person(firstName: "Sara", lastName: "Wong")
        
        var firstNames = ["Kori", "Rowan"]
        
        var rosterList = [rowan, sara]
        
        //var Ko
        
        
        
        println(rowan.fullName())
        
        println(rosterList[0].firstName + " " + rosterList[0].lastName)
        
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

