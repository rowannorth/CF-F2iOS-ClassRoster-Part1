//
//  DetailViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/12/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

protocol AddPersonDelegate {
    func addNewPerson(newPerson: Person)
}
protocol DetailViewControllerDelegate {
    func saveChanges()
}

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var peopleDestination: Person?
    var firstLoad = true
    var delegate: AddPersonDelegate!
    var saveData: DetailViewControllerDelegate?

//    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var gitHubTextField: UITextField!
    @IBOutlet weak var gitHubUserImage: UIImageView!
    @IBOutlet weak var gitHubActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.gitHubTextField.delegate = self
        
        
        if self.peopleDestination?.image != nil {
            
            self.imageView.image = self.peopleDestination!.image
            
        } else {
            
            self.imageView!.image = UIImage (named: "empty-contact-icon")
            
        }
       
        //Setting image to be rounded
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.borderColor = UIColor.blackColor().CGColor
      
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.firstNameTextField.text = self.peopleDestination?.firstName
        self.lastNameTextField.text = self.peopleDestination?.lastName
        self.gitHubTextField.text = self.peopleDestination?.gitHubUserName
        self.gitHubUserImage.image = self.peopleDestination?.gitHubProfileImage

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.peopleDestination?.firstName          = self.firstNameTextField.text
        self.peopleDestination?.lastName           = self.lastNameTextField.text
        self.peopleDestination?.gitHubUserName     = self.gitHubTextField.text
        self.peopleDestination?.gitHubProfileImage = self.gitHubUserImage.image
        
        if self.firstLoad == true {
            
            self.firstLoad = false
            
        }
        
        if self.peopleDestination == nil {

            var addingPerson = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text)
            self.delegate.addNewPerson(addingPerson)
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.saveData?.saveChanges()
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
        
        self.view.endEditing(true)
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
    
    
    @IBAction func gitHubButton(sender: AnyObject) {
        
        var alertTextField = UITextField()
        var enterGitHubInfo = UIAlertController(title: "Grab Info", message: "What is the person's GitHub username?", preferredStyle: UIAlertControllerStyle.Alert)
        enterGitHubInfo.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Username"
            alertTextField = textField
        })
        enterGitHubInfo.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        enterGitHubInfo.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.gitHubTextField.text = alertTextField.text
            self.peopleDestination?.gitHubUserName = alertTextField.text
            self.getGitHubProfileImage(alertTextField.text)
            })
        self.presentViewController(enterGitHubInfo, animated: true, completion: nil)
    }
    
    var imageDownloadQueue = NSOperationQueue()

    func getGitHubProfileImage(searchUserName: String) -> Void {

        self.gitHubActivityIndicator.startAnimating()
        let gitHubURL = NSURL (string: "https://api.github.com/users/\(searchUserName)")
        var profileImageURL = NSURL()
        self.imageDownloadQueue.addOperationWithBlock { () -> Void in
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(gitHubURL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    println("error 1")
                }
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if err != nil {
                    println("error 2")
                }
                if let avatarURL = jsonResult["avatar_url"] as? String {
                    profileImageURL = NSURL(string: avatarURL)
                }
                var profileImageData = NSData(contentsOfURL: profileImageURL)
                var profileImagePhoto = UIImage (data: profileImageData)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.gitHubUserImage.image = profileImagePhoto
                    self.peopleDestination?.gitHubProfileImage = profileImagePhoto
                    self.gitHubActivityIndicator.stopAnimating()
                    if self.gitHubUserImage.image == nil {
                        self.gitHubUserImage.image = UIImage(named: "gitHubDefaultImage")
                        self.gitHubTextField.text = nil
                        var alert = UIAlertView()
                        alert.title = "Invalid Username"
                        alert.message = "Please enter a valid GitHub Username"
                        alert.addButtonWithTitle("OK")
                        alert.show()
                    }
                })
            })
            task.resume()
        }

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
