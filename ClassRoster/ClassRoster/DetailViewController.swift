//
//  DetailViewController.swift
//  ClassRoster
//
//  Created by Rowan North on 8/12/14.
//  Copyright (c) 2014 Rowan North. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Connections & Variables
    
    var peopleDestination: Person?
    var imageDownloadQueue = NSOperationQueue()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var gitHubTextField: UITextField!
    @IBOutlet weak var gitHubUserImage: UIImageView!
    @IBOutlet weak var gitHubActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets DetailViewController as the delegate for all Text Fields.
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.gitHubTextField.delegate = self
        
        // Checks to see if the Person object already has an image set to it and loads that image into the imageView if it does.
        if self.peopleDestination?.image != nil {
            
            self.imageView.image = self.peopleDestination!.image
            
        } else {
            
            // Sets the default image of the imageView.
            self.imageView!.image = UIImage (named: "empty-contact-icon")
            
        }
        
        // Sets the default image of the gitHubUserImage.
        if self.gitHubUserImage.image == nil {
            self.gitHubUserImage.image = UIImage(named: "gitHubDefaultImage")
        }
       
        //Sets imageView to be rounded.
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
    /* 
    Sets the text properties of the Text Fields to the corresponding text properties of the selected Person object.
    Also sets the image property of the gitHubUserImage to the gitHubProfileImage of the selected Person object.
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.firstNameTextField.text = self.peopleDestination?.firstName
        self.lastNameTextField.text  = self.peopleDestination?.lastName
        self.gitHubTextField.text    = self.peopleDestination?.gitHubUserName
        self.gitHubUserImage.image   = self.peopleDestination?.gitHubProfileImage

    }
    
    /*
    Sets the text property of the selected Person object to the corresponding text properties of the Text Fields
    so that any changes made will be passed back when the view disappears.
    Does the same for the selected person's gitHubProfileImage property.
    */
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.peopleDestination?.firstName          = self.firstNameTextField.text
        self.peopleDestination?.lastName           = self.lastNameTextField.text
        self.peopleDestination?.gitHubUserName     = self.gitHubTextField.text
        self.peopleDestination?.gitHubProfileImage = self.gitHubUserImage.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Text Fields
    
    /*
    Offsets the view so that when the Text Fields are being edited the keyboard doesn't obstruct the view's content.
    There are known bugs to me that I've yet to fix such as it adjusting properly to landscape view and
    occasionally a weird interference with the hardware keyboard settings in the iOS simulator prevent the keyboard from popping
    up but the view is still offset, causing a gap of black on the bottom of the screen.
    */
    func textFieldDidBeginEditing(textField: UITextField) {

        switch textField {
            
        case self.firstNameTextField:
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y = -78
            })
        case self.lastNameTextField:
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y = -112
            })
        case self.gitHubTextField:
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.frame.origin.y = -162
            })
        default:
            
            self.view.frame.origin.y = 0
        }
        
    }
    
    // Returns the view to its original centered position after editing of the Text Fields is finished.
    func textFieldDidEndEditing(textField: UITextField!) {
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.frame.origin.y = 0
        })
        
    }
    
    // Dismisses the keyboard and editing of the Text Field when pressing the Return/Done key.
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // Forces the view (in particular, a Text Field) to resign first responder status in response to a touch event in the view's window.
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    //MARK: - User Photo
   
    // Launches an ImagePickerController to allow user to choose a photo from the photos album.
    @IBAction func uploadPhotoButton(sender: AnyObject) {
        

        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    /* 
    Sets the selected photo from the ImagePickerController to image property of the imageView
    as well as the image property of the selected Person object from the Table View.
    */
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        
        var editedImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        self.imageView.image = editedImage
        self.peopleDestination?.image = editedImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Dismisses ImagePickerController.
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: - GitHub Profile Name & Photo
    
    /*
    Button click launches an alert box with a text field that prompts the user to enter a GitHub username.
    Passes the entered text into the text property of the gitHubTextField property.
    Passes the entered text into the gitHubUserName property of the selected Person object.
    Passes the entered text into the parameter of the getGitHubProfileImage function so it can pull the 
    user's profile image from the GitHub API.
    */
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
    
    /*
    Passes in the String of a person's username into the URL for the GitHub API;
    A new queue is started along with an NSURL session that uses the GitHub API to fetch the URL value of the "avatar_url" key
    in the JSON dictionary. That URL holds the actual photo used for the user's GitHub profile image and it is converted into a
    usable form through NSData(contentsOfURL) which is then assigned as a UIImage.
    Hops back into the main queue and assigns the image property of gitHubUserImage to the photo pulled from the GitHub API.
    Also assigns the gitHubProfileImage property of the selected Person object to the photo pulled from the GitHub API.
    If there was no valid username/URL for the GitHub API then the default GitHub image is assigned, the text field is left nil and
    an alert view pops up to ask the user for a valid GitHub username.
    ImageDownloadQueue stops and the task resumes.
    */
    func getGitHubProfileImage(searchUserName: String) -> Void {

        self.gitHubActivityIndicator.startAnimating()
        let gitHubURL = NSURL(string: "https://api.github.com/users/\(searchUserName)")
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
                var profileImagePhoto = UIImage(data: profileImageData)
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
