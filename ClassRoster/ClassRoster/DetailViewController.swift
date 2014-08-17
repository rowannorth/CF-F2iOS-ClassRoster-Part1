//
//  DetailViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/12/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    var people: Person!
    
    @IBOutlet weak var firstNameTextField: UITextField!
   
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.text = self.people.fullName()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
    }

    
    override func viewWillDisappear(animated: Bool) {
        
        self.people.fullName() = self.textField.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
