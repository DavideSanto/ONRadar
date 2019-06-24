//
//  mmIC.swift
//  ONRadar
//
//  Created by Davide Santo on 24.06.19.
//  Copyright © 2019 Davide Santo. All rights reserved.
//

import Foundation
import RealmSwift

class mmICs: Object {
    
    @objc dynamic var mmICName : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //Radar Parameters
    @objc dynamic var numTX: Int = 4
    @objc dynamic var numRX: Int = 4
    @objc dynamic var chirpTotalTime: Float = 40.0
    @objc dynamic var numberChirps: Int = 512
    
    
    
    var parentCategory = LinkingObjects(fromType: Radar.self, property: "mmICs")  //an auto updating object that is used to define the inverse relationship  where each each item points to a parentCategory
}

