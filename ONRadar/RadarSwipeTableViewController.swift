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
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Deteled Project")
            self.updateModel(at: indexPath)  // call top local updateModel function for selected Cell
            
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print("FileManager Default Url location: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        // loadProjects()
        
        tableView.rowHeight = 70.0
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
