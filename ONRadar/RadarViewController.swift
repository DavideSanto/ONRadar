//
//  RadarViewController.swift
//  ONRadar
//
//  Created by Davide Santo on 24.06.19.
//  Copyright © 2019 Davide Santo. All rights reserved.
//

import UIKit
import RealmSwift

class RadarViewController: UIViewController {
    
    var realm = try! Realm()
    var selectedProject : Radar? { didSet {
        print("at config of mmIC ")
        //loadmmIC()
        }
        
    }

    @IBOutlet weak var nTx: UITextField!
    @IBOutlet weak var nRx: UITextField!
    @IBOutlet weak var netBw: UITextField!
    @IBOutlet weak var totalChirpTime: UITextField!
    @IBOutlet weak var numChirps: UITextField!
    
    
    @IBOutlet weak var maxRange: UILabel!
    @IBOutlet weak var rangeResolution: UILabel!
    @IBOutlet weak var maxVelocity: UILabel!
    @IBOutlet weak var velocityResolution: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

       self.title = selectedProject?.projectName ?? " test mmIC"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\n\n On the turning away \n\n")
    }

    @IBAction func butonComputePressed(_ sender: Any) {
        
        print("Butom Compute pressed ")
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .full
        
        do {
            try realm.write {
                selectedProject?.dateUpdated = currentDate
            }
        } catch {
            print("Error while Deleting Categories from Realm, \(error)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
