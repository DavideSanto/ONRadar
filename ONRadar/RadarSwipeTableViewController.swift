//
//  RadarSwipeTableViewController.swift
//  ONRadar
//
//  Created by Davide Santo on 24.06.19.
//  Copyright © 2019 Davide Santo. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class RadarSwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    //MARK: - Define Local Variables to access Realm and get location of DB on local HDD
    
    let realm = try! Realm()
    var radarProjects: Results<Radar>?
    
    //MARK:  - Swipe Delegated Function by SwipeTableViewCell Cocoapod

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }  // Only swipingright to left is managed. Action of Deletion is activated
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Deteled Project")
            self.updateModel(at: indexPath)  // call top local updateModel function for selected Cell
            
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    // Manage Expansion and Transition of Swipe...without this fucnbtion DELETING DOES NOT WORK in the VIEW (but does in the Realm DB)
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print("FileManager Default Url location: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        
        
        loadRadarProjects()
        
        tableView.rowHeight = 65.0
        self.title = "Radar Active Projects"
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRadarProjects()
        tableView.reloadData()
    }

    // MARK: - Table view data source and Cell Configuration functions

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Only one sections for now....we may have to update for multiple sections if we merge multiple product (NRxx) under one app
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Numbers of Saved/stored projects
        return radarProjects?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // get a handle to the Swiping Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! SwipeTableViewCell
        cell.delegate = self
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .full
        let dateString = dateFormatter.string(from: radarProjects?[indexPath.row].dateUpdated ?? currentDate)
        
        cell.textLabel?.text = radarProjects?[indexPath.row].projectName   // Populating Cell row with Saved Project name
       cell.detailTextLabel?.text = dateString

        return cell
    }


    @IBAction func addProjectButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .full
        dateFormatter.dateStyle = .full
        //let dateString = dateFormatter.string(from: currentDate)
        
        
        let alert = UIAlertController(title: "New Radar Project name:", message: "Add New Configuration", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Radar Project", style: .default, handler: { (action) in
            let newRadarProject = Radar()
            newRadarProject.projectName = textField.text!
            newRadarProject.dateCreated = currentDate
            newRadarProject.dateUpdated = currentDate
            self.saveRadarProjects(project: newRadarProject)
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Project"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    
    }
    
   
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "Radar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RadarViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedProject = radarProjects?[indexPath.row]
        }
        
    }
    
    
    //MARK: - Auxiliary Functions 9Save, Load Projects)
    
    func saveRadarProjects(project: Radar) {
        do {
            try realm.write {
                realm.add(project)
            }
        } catch {
            print("Failed in saving Project into Realm DB \(error)")
        }
        tableView.reloadData()
    }
    
    func loadRadarProjects() {
        radarProjects = realm.objects(Radar.self)
        tableView.reloadData()
    }
    

    func updateModel(at indexPath: IndexPath) {
            print("TO DO Update of Realm with Saving of Real")
            if let projectForDeletion = self.radarProjects?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(projectForDeletion)
                    }
                } catch {
                    print("Error while Deleting Categories from Realm, \(error)")
                }
            }
            
        }
    
}
