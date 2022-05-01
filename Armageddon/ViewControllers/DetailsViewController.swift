//
//  DetailsViewController.swift
//  Armageddon
//
//  Created by Денис on 27.04.2022.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentAsteroid: AsteroidCellModel!
    let networkManager = NetworkManager()
    var currentAsteroidDetails = [CurrentCloseApproachDates]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingIndicator()
        tableView.delegate = self
        tableView.dataSource = self
        prepareView()
    }
    
    func showLoadingIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    // Prepare view to show
    private func prepareView() {
        nameLabel.text = currentAsteroid.name
        if currentAsteroid.isPotentiallyHazardousAsteroid {
            nameLabel.textColor = .red
        } else {
            nameLabel.textColor = .green
        }
        let link = currentAsteroid.link.replacingOccurrences(of: "http://", with: "https://")
        networkManager.loadJson(fromURLString: link) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Parse JSON from link
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(CurrentAsteroidDetails.self, from: jsonData)
            currentAsteroidDetails = decodedData.closeApproachDates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Decode Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAsteroidDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AsteroidDetailsCell
        else { return UITableViewCell() }
        cell.setup(data: currentAsteroidDetails[indexPath.row])
        return cell
    }
}
