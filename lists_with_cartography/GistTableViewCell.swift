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
            descriptionLabel.text = gist?.gistDescription
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
        label.textAlignment = .right
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.sizeToFit()
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
            userNameLabel.height == 30
            userNameLabel.top == userNameLabel.superview!.top + 10
            userNameLabel.left == userNameLabel.superview!.left + 10
            
            userImageView.width == 45
            userImageView.height == 45
            userImageView.left == userNameLabel.left
            userImageView.top == userNameLabel.bottom + 5
            
            dateLabel.height == 20
            dateLabel.top == dateLabel.superview!.top + 10
            dateLabel.right == dateLabel.superview!.right - 10
            
            descriptionLabel.top == dateLabel.bottom + 5
            descriptionLabel.bottom == descriptionLabel.superview!.bottom + 5
            descriptionLabel.left == userImageView.right + 10
            descriptionLabel.right == descriptionLabel.superview!.right - 5
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
