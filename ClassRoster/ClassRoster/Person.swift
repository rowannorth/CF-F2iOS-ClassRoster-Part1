//
//  Person.swift
//  ClassRoster
//
//  Created by Rowan North on 8/9/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import Foundation
import UIKit

class Person: NSObject, NSCoding {
    
    var firstName          = String()
    var lastName           = String()
    var image              : UIImage?
    var gitHubUserName     : String?
    var gitHubProfileImage : UIImage?
   
    
    init (firstName :String, lastName :String) {
        
        self.firstName = firstName
        self.lastName  = lastName
        
    }
    
    func fullName() -> String {
        
        return firstName + " " + lastName
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
                aCoder.encodeObject(self.firstName, forKey: "firstName")
                aCoder.encodeObject(self.lastName, forKey: "lastName")
        if self.image != nil {
            
            aCoder.encodeObject(self.image!, forKey: "image")
        }
        if self.gitHubUserName != nil {
            aCoder.encodeObject(self.gitHubUserName!, forKey: "gitHubUserName")
        }
        if self.gitHubProfileImage != nil {
            aCoder.encodeObject(self.gitHubProfileImage!, forKey: "gitHubPic")
        }
            
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName  = aDecoder.decodeObjectForKey("lastName") as String
        if let myImage = aDecoder.decodeObjectForKey("image") as? UIImage {
            self.image = myImage
        }
        if let myGitHubName = aDecoder.decodeObjectForKey("gitHubUserName") as? String {
            self.gitHubUserName = myGitHubName
        }
        if let myGitHubProfileImage = aDecoder.decodeObjectForKey("gitHubPic") as? UIImage {
            self.gitHubProfileImage = myGitHubProfileImage
        }
    }
    
}