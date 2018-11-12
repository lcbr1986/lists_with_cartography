//
//  DetailViewController.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 12/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import UIKit
import Cartography

class DetailViewController: UIViewController {

    var gist: Gist?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(dateLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(userImageView)
        
        constrain(dateLabel, titleLabel, userImageView) { dateLabel, titleLabel, userImageView in
            titleLabel.top == titleLabel.superview!.top + 90
            titleLabel.leading == titleLabel.superview!.leading + 5
            titleLabel.trailing == titleLabel.superview!.trailing - 5
            
            dateLabel.top == titleLabel.bottom + 10
            dateLabel.width == 200
            dateLabel.height == 30
            dateLabel.centerX == dateLabel.superview!.centerX
            
            userImageView.width == 100
            userImageView.height == 100
            userImageView.top == dateLabel.bottom + 20
            userImageView.centerX == userImageView.superview!.centerX
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let gist = self.gist else {
            return
        }
        self.title = gist.ownerName
        titleLabel.text = gist.gistDescription
        if let date = gist.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            dateLabel.text = dateFormatter.string(from: date)
        }
        if let avatarUrl = gist.ownerAvatarUrl {
            userImageView.imageFromURL(urlString: avatarUrl)
        }
    }
}
