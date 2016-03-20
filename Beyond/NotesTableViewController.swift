//
//  NotesTableViewController.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var notes = [Note]()
    
    var searchResults = [Note]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchResultController:NSFetchedResultsController!
    
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchResultsController()
        
        setupSearchController()
        
        title = "Beyond"
        tableView.tableFooterView = UIView()
        
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    func filterContentForSearchText(searchText: String) {
        searchResults = notes.filter({ note in
        note.title.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "Search notes..."
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red: 30.0/255.0, green:
        30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }
    
    func setupFetchResultsController() {
        
        let fetchRequest = NSFetchRequest(entityName: "Note")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                notes = fetchResultController.fetchedObjects as! [Note]
            } catch {
                print(error)
            }
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            case .Insert:
                if let _newIndexPath = newIndexPath {
                    tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
                }
            case .Delete:
                if let _indexPath = indexPath {
                    print(_indexPath.row)
                    tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
                }
            case .Update:
                if let _indexPath = indexPath {
                    tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
                }
            default:
                tableView.reloadData()
        }
        notes = controller.fetchedObjects as! [Note]
        if searchController.active {
            searchResults = notes
            updateSearchResultsForSearchController(searchController)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return searchResults.count
        } else {
            return notes.count
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active && searchController.searchBar.text != "" {
            return false
        } else {
            return true
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteTableViewCell", forIndexPath: indexPath) as! NoteTableViewCell
        
        let note = (searchController.active && searchController.searchBar.text != "") ? searchResults[indexPath.row] : notes[indexPath.row]
        
        // Configure the cell...
        cell.titleTextLabel.text = note.title
        cell.contentTextLabel.text = note.content
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentDetailedNoteView" {
            if let destinationViewController = segue.destinationViewController as? NotesDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationViewController.note = (searchController.active && searchController.searchBar.text != "") ? searchResults[indexPath.row] : notes[indexPath.row]
                }
            }
        }
    }
    
    @IBAction func deleteNoteUnwindSegue(segue: UIStoryboardSegue) {
        print("I have come here now...")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
