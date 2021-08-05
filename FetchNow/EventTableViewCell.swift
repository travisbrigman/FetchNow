//
//  EventTableViewCell.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    var event: Event? {
        didSet {
            eventNameLabel.text = event?.title
            location.text = event?.venue.displayLocation
            date = event?.dateTimeLocal ?? Date()
            dateString.text = formatter.string(from: date)
            eventImage.image = fetchImage(photoURL: event?.performers[0].image)
        }
    }
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let location: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private var date: Date = {
        let date = Date()
        return date
    }()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    private let dateString: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private let eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "heartFilled"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func showFavoriteIcon() {
        addSubview(favoriteIcon)
        favoriteIcon.anchor(top: nil, left: dateString.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 1, paddingLeft: 1, paddingBottom: 1, paddingRight: 5, width: 20, height: frame.size.height, enableInsets: false)
    }
    
    func removeFavoriteIcon() {
        if !favoriteIcon.isHidden {
            favoriteIcon.removeFromSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(eventNameLabel)
        addSubview(location)
        addSubview(dateString)
        addSubview(eventImage)

        eventImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 80, height: 0, enableInsets: false)
        eventNameLabel.anchor(top: topAnchor, left: eventImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 2, width: frame.size.width, height: 0, enableInsets: false)
        location.anchor(top: eventNameLabel.bottomAnchor, left: eventImage.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        dateString.anchor(top: location.bottomAnchor, left: eventImage.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fetchImage(photoURL: String?) -> UIImage {
        guard let imageURL = URL(string: photoURL ?? "no URL found") else { return
            UIImage()
        }
        
        let imageData: Data = try! Data(contentsOf: imageURL)
        
        guard let image = UIImage(data: imageData) else { return UIImage() }
        
        return image
    }
}
