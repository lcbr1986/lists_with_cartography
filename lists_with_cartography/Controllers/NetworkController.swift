//
//  NetworkController.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 12/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

class NetworkController {
    
    public func getGists(page: Int, completionHandler: @escaping (Data?, Error?) -> Void) {
        let endpoint = "https://api.github.com/gists/public?page=\(page)"
        
        createRequest(urlString: endpoint, completionHandler: completionHandler)
    }
    
    private func createRequest(urlString: String, method: String = "GET", body: Data? = nil, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            completionHandler(responseData, nil)
        })
        task.resume()
    }
}
