//
//  ViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/9/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.createPeople()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tableView.reloadData()
        
    }
    
    func createPeople() {
        
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
        
        var peopleList = [nate, matthew, jeff, christie, david, adrian, jake, shams, cameron, kori, parker, nathan, casey, brendan, brian, mark, rowan, kevin, will, heather, tuan, zack, sara, hongyao]
   
        self.people = peopleList
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return self.people.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var personForRow = self.people[indexPath.row]
        
        cell.textLabel.text = personForRow.fullName()
        
        cell.backgroundColor = UIColor.grayColor()
        
        return cell
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        
        println(indexPath.item)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    
    if segue.identifier == "showDetails" {
        
    var destination = segue.destinationViewController as DetailViewController
        
    destination.people = people[tableView.indexPathForSelectedRow().row]
    
    
}