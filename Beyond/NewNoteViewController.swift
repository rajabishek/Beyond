//
//  NewNoteViewController.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import CoreData

class NewNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    let contentViewPlaceHolderText = "Start Writing..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Start Writing"
        contentTextView.text = contentViewPlaceHolderText
        contentTextView.textColor = UIColor.lightGrayColor()
        contentTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonWasPressed(sender: UIBarButtonItem) {
        Note.createNoteAndSave(self.titleTextField.text!, content: self.contentTextView.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeButtonWasPressed(sender: UIBarButtonItem) {
        
        if (titleTextField.text! == "" && contentTextView.text! == contentViewPlaceHolderText) || (titleTextField.text! == "" && contentTextView.text! == "") {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Caution", message: "You have something written. Sure don't wanna save ?", preferredStyle: .Alert)
            let saveAction = UIAlertAction(title: "Save", style: .Default) { action in
                Note.createNoteAndSave(self.titleTextField.text!, content: self.contentTextView.text!)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            let closeAction = UIAlertAction(title: "Never Mind", style: UIAlertActionStyle.Destructive) { action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(closeAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension NewNoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = contentViewPlaceHolderText
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}
