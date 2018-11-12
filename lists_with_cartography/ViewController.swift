//
//  ViewController.swift
//  lists_with_cartography
//
//  Created by Luís Rosa on 10/11/2018.
//  Copyright © 2018 Luís Rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gists"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
    }
    
    func setupTableView() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 33
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GistTableViewCell
        var gist = Gist()
        gist.date = Date()
        gist.description = "item hfoehjsfioaesh fjhe afuehfu aehu dfeiuah fiuhaiufheaiuhaeiuheiuh eaiuhae uhea iueah iueahiaeuhe aiuhae oiuaeh e \(indexPath.row)"
        gist.ownerName = "Blabla"
        gist.ownerAvatarUrl = "https://avatars0.githubusercontent.com/u/19759053?v=4"
        
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
    }
}
