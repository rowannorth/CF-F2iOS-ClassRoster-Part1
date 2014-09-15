//
//  ViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/9/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewPersonDelegate {
    
    //MARK: - Connections & Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Person]()
    var teachers = [Person]()
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    

    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the root ViewController as the delegate and datasource for the Table View.
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        
        // Checks to see if there is any data saved to disk and loads it if there is.
        if let students = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath + "/studentarchive") as? [Person] {
            
            self.students = students
            
        } else {
            
            // Generates students[] array the first time the app loads.
            self.createStudents()
            
        }
        
        // Checks to see if there is any data saved to disk and loads it if there is.
        if let teachers = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath + "/teacherarchive") as? [Person] {
            
            self.teachers = teachers
            
        } else {
            
            // Generates teachers[] array the first time the app loads.
            self.createTeachers()
            
        }
        
    }
    
    // Refreshes the Table View and saves any changes that were made in another view.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        self.saveChanges()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View
    
    //Hard codes the Table View to have 2 sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    //Sets the number of Table View cells in each section to the count of the students[] and teachers[] arrays.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.students.count
        } else {
            return self.teachers.count
        }
    }
    
    /* 
    Generates a reusable Table View cell and sets the name based on the items in both students[] and
    teachers[] arrays depending on the Table View section that is selected.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
        
            var studentForRow = self.students[indexPath.row]
            
            cell.textLabel!.text = studentForRow.fullName()
            
        } else {
        
            var teacherForRow = self.teachers[indexPath.row]
            
            cell.textLabel!.text = teacherForRow.fullName()
    
        }
        
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true

    }
    
    // Deletes items in the Table View and saves any changes.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if editingStyle == .Delete {

            if indexPath.section == 0 {
                self.students.removeAtIndex(indexPath!.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)

            } else {
                self.teachers.removeAtIndex(indexPath!.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)

            }
        }

        self.tableView.reloadData()
        self.saveChanges()
    }
    
    // Sets title for each section of the Table View.
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String! {
        
        if section == 0 {
            
            return "Students"
            
        } else {
            
            return "Teachers"
            
        }
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "showPeople" {
            
            if tableView.indexPathForSelectedRow()!.section == 0 {
                
                var peopleDestination = self.students[tableView.indexPathForSelectedRow()!.row]
                
                let studVC = segue.destinationViewController as DetailViewController
                
                studVC.peopleDestination = peopleDestination
                
            } else {
                
                var peopleDestination = self.teachers[tableView.indexPathForSelectedRow()!.row]
                
                let teachVC = segue.destinationViewController as DetailViewController
                
                teachVC.peopleDestination = peopleDestination
                
            }
            
            
        } else if segue.identifier == "addPerson" {
            
        
            let addVC = segue.destinationViewController as AddPersonViewController

            addVC.delegate = self
            
            
        } else {}
        
    }
    
    //MARK: - Custom Methods
    
    // Generates students[] array.
    func createStudents() {
        
        var nate = Person(firstName: "Nate", lastName: "Birkholz")
        var matthew = Person(firstName: "Matthew", lastName: "Brightbill")
        var jeff = Person(firstName: "Jeff", lastName: "Chavez")
        var christie = Person(firstName: "Christie", lastName: "Ferderer")
        var david = Person(firstName: "David", lastName: "Fry")
        var adrian = Person(firstName: "Adrian", lastName: "Gherle")
        var jake = Person(firstName: "Jake", lastName: "Hawken")
        var shams = Person(firstName: "Shams", lastName: "Kazi")
        var cameron = Person(firstName: "Cameron", lastName: "Klein")
        var kori = Person(firstName: "Kori", lastName: "Kolodziejczak")
        var parker = Person(firstName: "Parker", lastName: "Lewis")
        var nathan = Person(firstName: "Nathan", lastName: "Ma")
        var casey = Person(firstName: "Casey", lastName: "MacPhee")
        var brendan = Person(firstName: "Brendan", lastName: "McAleer")
        var brian = Person(firstName: "Brian", lastName: "Mendez")
        var mark = Person(firstName: "Mark", lastName: "Morris")
        var rowan = Person(firstName: "Rowan", lastName: "North")
        var kevin = Person(firstName: "Kevin", lastName: "Pham")
        var will = Person(firstName: "Will", lastName: "Richman")
        var heather = Person(firstName: "Heather", lastName: "Thueringer")
        var tuan = Person(firstName: "Tuan", lastName: "Vu")
        var zack = Person(firstName: "Zack", lastName: "Walkingstick")
        var sara = Person(firstName: "Sara", lastName: "Wong")
        var hongyao = Person(firstName: "Hongyao", lastName: "Zhang")
        
        var studentList = [nate, matthew, jeff, christie, david, adrian, jake, shams, cameron, kori, parker, nathan, casey, brendan, brian, mark, rowan, kevin, will, heather, tuan, zack, sara, hongyao]
        
        self.students = studentList
        
    }
    
    // Generates teachers[] array.
    func createTeachers() {
        
        var john = Person(firstName: "John", lastName: "Clem")
        var brad = Person(firstName: "Brad", lastName: "Johnson")
        
        self.teachers.append(john)
        self.teachers.append(brad)
        
    }
    
    // Adds newly created person object to students[] array.
    func appendNewPersonToArray(controller: AddPersonViewController, newAddedPerson: Person) {
        
        
        self.students.append(newAddedPerson)
        
        self.tableView.reloadData()
    }
    
    func saveChanges() {
        NSKeyedArchiver.archiveRootObject(students, toFile: documentsPath + "/studentarchive")
        NSKeyedArchiver.archiveRootObject(teachers, toFile: documentsPath + "/teacherarchive")
    }
    
}