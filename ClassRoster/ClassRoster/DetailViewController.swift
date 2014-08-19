//
//  DetailViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/12/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var students: Person!
    var teachers: Person!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        //students
        self.firstNameTextField.text = self.students.firstName
        self.lastNameTextField.text = self.students.lastName
        
        //teachers
        self.firstNameTextField.text = self.teachers.firstName
        self.lastNameTextField.text = self.teachers.lastName
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        
        //students
        self.students.firstName = self.firstNameTextField.text
        self.students.lastName = self.lastNameTextField.text
        
        //teachers
        self.teachers.firstName = self.firstNameTextField.text
        self.teachers.lastName = self.lastNameTextField.text
        
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
