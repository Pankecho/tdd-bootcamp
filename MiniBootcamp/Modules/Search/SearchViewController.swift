//
//  SearchViewController.swift
//  MiniBootcamp
//
//  Created by Juan Pablo Martinez Ruiz on 23/06/22.
//

import UIKit

final class SearchViewController: UIViewController {
    let tableView: UITableView = create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tweetsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TweetCell,
              viewModel.tweetsCount > 0 else { return TweetCell() }
        
        let item = viewModel.getItem(at: indexPath.row)
        cell.configure(name: item.userName, username: item.screenName, text: item.content)
        return cell
    }
}
