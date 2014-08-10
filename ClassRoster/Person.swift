//
//  Person.swift
//  ClassRoster
//
//  Created by Rowan North on 8/9/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import Foundation

class Person {
    
    var firstName = String()
    var lastName  = String()
    var image     : UIImage?
    
    init (firstName :String, lastName :String) {
        
        self.firstName = firstName
        self.lastName  = lastName
        
    }
    
    func fullName() -> String {
        
        return firstName + " " + lastName
        
    }
    
}