//
//  DetailViewController.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/22/21.
//

import UIKit

class DetailViewController: UIViewController {
//    var favorites = Favorites()
    var tableView = TableViewController()
    var detailItem: Event?
    
    @IBOutlet weak var event: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    let heartOutline = UIImage(named: "heartOutline.png")
    let heartFilled = UIImage(named: "heartFilled.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        guard let detailItem = detailItem else { return }
        
        title = detailItem.shortTitle
        
        navigationItem.rightBarButtonItem = barButtonItem(isFavorited: Favorites.shared.contains(detailItem))
        
        event.text = detailItem.title
        date.text = formatter.string(from: detailItem.dateTimeLocal)
        location.text = detailItem.venue.displayLocation
        let imageURL = URL(string: detailItem.performers[0].image ?? "no image found")
        fetchImage(imageURL)
    }
    
    private func fetchImage(_ photoURL: URL?) {
        
        guard let imageURL = photoURL else { return  }
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData: Data = try Data(contentsOf: imageURL)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.imageView.image = image
                    self.imageView.sizeToFit()
                    
                }
            } catch {
                print("Unable to load data: \(error)")
            }
        }
    }
    
    func barButtonItem(isFavorited: Bool) -> UIBarButtonItem {
        return UIBarButtonItem(
            image: isFavorited ? heartFilled : heartOutline,
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
    }
    
    @objc func favoriteTapped() {
        guard let detailItem = detailItem else { return }

        var message = ""
        
        if !Favorites.shared.contains(detailItem) {
            Favorites.shared.add(detailItem)
            message = "you favorited this event"
        } else {
            Favorites.shared.remove(detailItem)
            message = "you un-favorited this event"
        }
        let ac = UIAlertController(title: "Favorite", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: .none))
        present(ac, animated: true)
        
        navigationItem.rightBarButtonItem = barButtonItem(isFavorited: Favorites.shared.contains(detailItem))
        tableView.reload()
    }
}
