//
//  FilterViewController.swift
//  Armageddon
//
//  Created by Денис on 25.04.2022.
//

import UIKit


class FilterViewController: UIViewController {
    
    var distanceString = ""
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var switcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelectedOptions()
    }
    
    // Checking settings to show
    func setupSelectedOptions() {
        if filter.isFiltering {
            switcher.isOn = true
        }
        if filter.distanceOption == "lun" {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    // Saving chosen parameters in UserDefaults
    func saveParameters() {
        if switcher.isOn {
            filter.isFiltering = true
        } else {
            filter.isFiltering = false
        }
        filter.distanceOption = distanceString
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            distanceString = "km"
        case 1:
            distanceString = "lun"
        default:
            break
        }
    }
}


