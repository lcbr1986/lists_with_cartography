//
//  ViewController.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 10/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import UIKit
import RealmSwift

let cellId = "cell"

class ViewController: UIViewController {

    var tableView: UITableView = UITableView()
    var gistFetcher = GistFetcher()
    var currentPage = 0
    var gistsToDisplay = [Gist]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gists"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        getListOfGist()
    }
    
    func setupTableView() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.view.addSubview(tableView)
    }
    
    func getListOfGist() {
        self.gistFetcher.getGistsFor(page: currentPage) { [weak self] (gistList, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            guard let gists = gistList else {
                return
            }
            self?.gistsToDisplay.append(contentsOf: gists)
            DispatchQueue.main.async {
                self?.storeGistsLocally(gists: gists)
                self?.tableView.reloadData()
            }
        }
    }
    
    func storeGistsLocally(gists: [Gist]) {
        for gist in gists {
            try! realm.write {
                realm.create(Gist.self, value: gist, update: true)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GistTableViewCell
        let gist = gistsToDisplay[indexPath.row]
        cell.gist = gist
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.gist = gistsToDisplay[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.gistsToDisplay.count - 1 {
            currentPage += 1
            getListOfGist()
        }
    }
}
