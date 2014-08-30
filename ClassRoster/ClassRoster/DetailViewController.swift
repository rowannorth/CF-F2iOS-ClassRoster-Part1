//
//  DetailViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/12/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
    func addNewPerson(newPerson: Person, image: UIImage?)
}

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var peopleDestination: Person?
//    var defaultImageIcon = UIImage(named: "defaultIcon")
    var firstLoad = true
    
    var delegate : AddPersonDelegate?
   
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        
        if self.peopleDestination?.image != nil {
            
            self.imageView.image = self.peopleDestination!.image
            
        } else {
            
            self.imageView!.image == UIImage (named: "empty-contact-icon")
            
        }
        
      
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.firstNameTextField.text = self.peopleDestination?.firstName
        self.lastNameTextField.text = self.peopleDestination?.lastName
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.peopleDestination?.firstName = self.firstNameTextField.text
        self.peopleDestination?.lastName = self.lastNameTextField.text
        
        if self.firstLoad == true {
            
            self.firstLoad = false
            
        }
        
        if self.peopleDestination == nil {
            self.delegate?.addNewPerson(Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text), image: self.imageView.image?)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        self.view .endEditing(true)
    }
    
   
    @IBAction func uploadPhotoButton(sender: AnyObject) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        
        println("User picked an image")
        
        var editedImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        self.imageView.image = editedImage
        self.peopleDestination?.image = editedImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
