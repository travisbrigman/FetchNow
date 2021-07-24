//
//  EventTableViewCell.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fetchImage(_ photoURL: URL?) {

        guard let imageURL = photoURL else { return  }

        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)

                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.eventImage.image = image
                    self.eventImage.contentMode = .scaleAspectFill
                    self.eventImage.clipsToBounds = true

                }
            }catch{
                print("Unable to load data: \(error)")
            }
        }
    }
}
