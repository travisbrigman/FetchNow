//
//  EventTableViewCell.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    let favorites = Favorites()
    
    var event: Event? {
        didSet {
            eventNameLabel.text = event?.title
            location.text = event?.venue.displayLocation
            date.text = event?.dateTimeLocal
            eventImage.image = fetchImage(photoURL: event?.performers[0].image)
        }
    }
    
    private let eventNameLabel : UILabel = {
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
    
    private let date: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private let eventImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteIcon : UIImageView = {
        let imageView = UIImageView(image: (#imageLiteral(resourceName: "heartFilled")))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(eventNameLabel)
        addSubview(location)
        addSubview(date)
        addSubview(eventImage)
//        if favorites.contains(event) {
//            addSubview(favoriteIcon)
//        }
        
        eventImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 80, height: 0, enableInsets: false)
        eventNameLabel.anchor(top: topAnchor, left: eventImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 2, width: frame.size.width, height: 0, enableInsets: false)
        location.anchor(top: eventNameLabel.bottomAnchor, left: eventImage.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        date.anchor(top: location.bottomAnchor, left: eventImage.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
//        favoriteIcon.anchor(top: topAnchor, left: date.rightAnchor, bottom: nil, right: nil, paddingTop: 1, paddingLeft: 1, paddingBottom: 1, paddingRight: 1, width: 20, height: 20, enableInsets: false)
        
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
