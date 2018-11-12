//
//  Gist.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 12/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import Foundation

struct Gist {
    var description: String?
    var date: Date?
    var ownerName: String?
    var ownerAvatarUrl: String?
    
    init(dict: [String: Any]) {
        self.description = dict["description"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.date = dateFormatter.date(from: (dict["created_at"] as? String)!)!
        if let owner = dict["owner"] as? [String: Any],
        let ownerName = owner["login"] as? String,
        let ownerAvatarUrl = owner["avatar_url"] as? String {
            self.ownerName = ownerName
            self.ownerAvatarUrl = ownerAvatarUrl
        }
    }
    
    init() {
        
    }
}
