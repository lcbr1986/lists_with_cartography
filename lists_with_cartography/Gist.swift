//
//  Gist.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 12/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import Foundation
import RealmSwift

class Gist: Object {
    @objc dynamic var gistDescription: String?
    @objc dynamic var date: Date?
    @objc dynamic var ownerName: String?
    @objc dynamic var ownerAvatarUrl: String?
    @objc dynamic var gistId: String = ""
    
    override static func primaryKey() -> String? {
        return "gistId"
    }
    
    convenience init?(dict: [String: Any]) {
        self.init()
        guard let gistId =  dict["id"] as? String else {
            return nil
        }
        self.gistId = gistId
        self.gistDescription = dict["description"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.date = dateFormatter.date(from: (dict["created_at"] as? String)!)!
        if let owner = dict["owner"] as? [String: Any],
        let ownerName = owner["login"] as? String,
        let ownerAvatarUrl = owner["avatar_url"] as? String {
            self.ownerName = ownerName
            self.ownerAvatarUrl = ownerAvatarUrl
        }
    }
    
}
