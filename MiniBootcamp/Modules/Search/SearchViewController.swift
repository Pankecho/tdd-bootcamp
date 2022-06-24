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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    }
}

extension SearchViewController: UITableViewDelegate { }

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        TweetCell()
    }
}
