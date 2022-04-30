//
//  ListOfDestroyViewController.swift
//  Armageddon
//
//  Created by Денис on 25.04.2022.
//

import UIKit

class ListOfDestroyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var asteroidsNamesArray: [String] = []
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }
    
    private func loadData() {
        if let loadedString = UserDefaults.standard.stringArray(forKey: "destroy") {
            asteroidsNamesArray = loadedString
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroidsNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = asteroidsNamesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            asteroidsNamesArray.remove(at: indexPath.row)
            
            var strings: [String] = userDefaults.stringArray(forKey: "destroy") ?? []
            
            strings.remove(at: indexPath.row)
            userDefaults.set(strings, forKey: "destroy")
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    
    @IBAction func deleteAllRecordsButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Внимание!", message: "Будет вызвана бригада им. Брюса Уиллиса! Готовы?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Да!", style: .destructive) { action in
            feedbackGenerator.impactOccurred()
            self.userDefaults.removeObject(forKey: "destroy")
            self.asteroidsNamesArray.removeAll()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Пока что нет", style: .default) { _ in }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
