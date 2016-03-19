//
//  NotesDetailViewController.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {
    
    var note: Note!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Keep Writing"
    
        titleTextField.text = note.title
        contentTextView.text = note.content
    }
    
    override func viewWillDisappear(animated: Bool) {
        note.title = titleTextField.text!
        note.content = contentTextView.text!
        note.save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteButtonWasPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this note ?", preferredStyle: .Alert)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            self.note.remove()
            self.performSegueWithIdentifier("deleteNoteUnwindSegue", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
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
