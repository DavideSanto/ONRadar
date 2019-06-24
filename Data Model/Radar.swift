//
//  Radar.swift
//  ONRadar
//
//  Created by Davide Santo on 24.06.19.
//  Copyright © 2019 Davide Santo. All rights reserved.
//

import Foundation
import RealmSwift

class Radar : Object {
    
    @objc dynamic var projectName : String = ""  //Can indicate Customer or Project names
    let radarProjects = List<mmICs>() // Empty List of mmIC perProject
    
}
