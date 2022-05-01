//
//  AsteroidsViewController.swift
//  Armageddon
//
//  Created by Денис on 25.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController, UITableViewDataSource {
    
    let filter = FilterManager()
    var asteroids = [AsteroidCellModel]()
    var interactor: AsteroidsBuisnessLogic?
    var dangerousAsteroidsArray = [AsteroidCellModel]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        load(data: asteroids)
        configureTableView()
        time.getData()
        interactor?.fetchAsteroids(andStop: activityIndicator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func load(data: [AsteroidCellModel]) {
        asteroids.append(contentsOf: data)
        filter(data: data)
        tableView.reloadData()
    }
    
    // Filtering only "PotentiallyHazardousAsteroids"
    private func filter(data: [AsteroidCellModel]) {
        for rock in data {
            if rock.isPotentiallyHazardousAsteroid {
                dangerousAsteroidsArray.append(rock)
            }
        }
    }
    
    // Delete cell method
    func deleteAsteroidCell(with indexPath: IndexPath) {
        if filter.isFiltering {
            dangerousAsteroidsArray.remove(at: indexPath.row)
        } else {
            asteroids.remove(at: indexPath.row)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .middle)
        tableView.endUpdates()
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    private func setup() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let viewController = self
        let presenter = AsteroidsPresenter()
        let interactor = AsteroidsInteractor()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let asteroidCell = UINib(nibName: "AsteroidCell", bundle: nil)
        self.tableView.register(asteroidCell,forCellReuseIdentifier: "asteroidCell")
    }
    
    private func beginUpdateTableView() {
        interactor?.fetchAsteroids(andStop: activityIndicator)
        print("updating")
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filter.isFiltering {
            return dangerousAsteroidsArray.count
        }
        return asteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidCell", for: indexPath) as? AsteroidCell
        else { return UITableViewCell() }
        cell.delegate = self
        cell.cellBackground.applyShadow(shadowRadius: 10)
        if filter.isFiltering {
            cell.setup(data: dangerousAsteroidsArray[indexPath.row])
        } else {
            cell.setup(data: asteroids[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: nil)
    }
    
    // Portion data loading
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            /// Adding 1 day then load more data
            time.addingDay(1)
            DispatchQueue.main.async {
                self.beginUpdateTableView()
            }
        }
    }
    
    // Pass data to DetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let asteroid = filter.isFiltering ? dangerousAsteroidsArray[indexPath.row] : asteroids[indexPath.row]
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.currentAsteroid = asteroid
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let filterVC = segue.source as? FilterViewController else { return }
        filterVC.saveParameters()
        tableView.reloadData()
    }
}
