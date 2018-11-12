//
//  GistFetcher.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 12/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import Foundation

class GistFetcher {
    let networkController = NetworkController()
    
    func getGistsFor(page: Int, completionHandler: @escaping ([Gist]?, Error?) -> Void) {
        var gists = [Gist]()
        networkController.getGists(page: page) { (data, error) in
            guard let data = data else {
                return
            }
            do {
                if let gistArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for gistDict in gistArray {
                        let gist = Gist(dict: gistDict)
                        gists.append(gist)
                    }
                }
                completionHandler(gists, error)
            } catch {
                completionHandler(nil, error)
            }
            
        }
    }
}
