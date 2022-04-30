//
//  FilterManager.swift
//  Armageddon
//
//  Created by Денис on 28.04.2022.
//

import Foundation

let filter = FilterManager()

class FilterManager {
    var isFiltering: Bool! {
         get {
             UserDefaults.standard.bool(forKey: "filter")
         } set {
             let defaults = UserDefaults.standard
             let key = "filter"
             if let active = newValue {
                 defaults.set(active, forKey: key)
             } else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
    
    // Filtering options
    var distanceOption: String! {
         get {
             UserDefaults.standard.string(forKey: "distance")
         } set {
             let defaults = UserDefaults.standard
             let key = "distance"
             if let active = newValue {
                 defaults.set(active, forKey: key)
             } else {
                 defaults.removeObject(forKey: key)
             }
         }
     }
}
