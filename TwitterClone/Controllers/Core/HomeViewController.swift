//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Lucas Newlands on 26/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let timeLineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableTableViewCell.self, forCellReuseIdentifier: TweetTableTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeLineTableView)
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        view.backgroundColor = .systemBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTableView.frame = view.frame
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableTableViewCell.identifier, for: indexPath) as? TweetTableTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}
