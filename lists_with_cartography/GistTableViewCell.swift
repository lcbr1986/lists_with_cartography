//
//  GistTableViewCell.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 10/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import UIKit
import Cartography

class GistTableViewCell: UITableViewCell {
    
    var gist: Gist? {
        didSet {
            descriptionLabel.text = gist?.description
            userNameLabel.text = gist?.ownerName
            if let avatarUrl = gist?.ownerAvatarUrl {
                userImageView.imageFromURL(urlString: avatarUrl)
            }
            if let date = gist?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd,yyyy"
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        addSubview(userImageView)
        addSubview(userNameLabel)
        
        constrain(dateLabel, descriptionLabel, userNameLabel, userImageView) { dateLabel, descriptionLabel, userNameLabel, userImageView in
            userNameLabel.width == 100
            userNameLabel.height == 20
            userNameLabel.left == userNameLabel.superview!.left + 10
            userNameLabel.top == userNameLabel.superview!.top + 10
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
