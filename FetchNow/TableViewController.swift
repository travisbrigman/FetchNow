//
//  TableViewController.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/22/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    var events = [Event]()
    var filteredEvents = [Event]()
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        
        let urlString: String
        urlString = "https://api.seatgeek.com/2/events?client_id=MjI2MjA3NTR8MTYyNjk2MTc5Ny41OTgwMTI"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    }
    
    
    func parse(json: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            let decodedResponse = try jsonDecoder.decode(Welcome.self, from: json)
            events = decodedResponse.events
            filteredEvents = events
            tableView.reloadData()
        } catch {
            print(error)
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredEvents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let singleEvent = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleEvent", for: indexPath)
        
        cell.textLabel?.text = singleEvent.title
        cell.detailTextLabel?.text = singleEvent.venue.displayLocation
        
        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its properties
            vc.detailItem = events[indexPath.row]
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredEvents = []
        
        if searchText == "" {
            filteredEvents = events
        } else {
            let urlString =  "https://api.seatgeek.com/2/events?q=\(searchText.replacingOccurrences(of: " ", with: "+"))&client_id=MjI2MjA3NTR8MTYyNjk2MTc5Ny41OTgwMTI"
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                    return
                }
            }
            filteredEvents = events
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
