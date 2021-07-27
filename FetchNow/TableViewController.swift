//
//  TableViewController.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/22/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    let dataProvider = Provider()
    
    var events = [Event]()
    var filteredEvents = [Event]()
    
    lazy var searchBar: UISearchBar = UISearchBar()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildSearchBar()
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "SingleEvent")
        
        dataProvider.getResults(query: "") { [weak self] result in
            switch result {
            case .success(let results):
                self?.events = results.events
                self?.filteredEvents = self!.events
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                
            case .failure(let error):
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(ac, animated: true)
                }
                print(error)
            }
        }
    }
    
    func buildSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredEvents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let singleEvent = events[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleEvent", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        cell.event = singleEvent
        if Favorites.shared.contains(singleEvent){
            DispatchQueue.main.async {
                cell.showFavoriteIcon()
                self.reload()
            }
            
        } else {
            DispatchQueue.main.async {
                cell.removeFavoriteIcon()
                self.reload()
            }
            
        }
        
        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = events[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var timer = Timer()
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        
        filteredEvents = []
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.dataProvider.getResults(query: searchText) { [weak self] result in
            switch result {
            case .success(let results):
                self?.events = results.events
                self?.filteredEvents = self!.events
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                
            case .failure(let error):
                DispatchQueue.main.async {
                    let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(ac, animated: true)
                }
                print(error)
            }
        }
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
