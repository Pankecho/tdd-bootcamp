//
//  FeedViewController.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func goToSearch()
}

class FeedViewController: UIViewController {
    let tableView: UITableView = create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    weak var delegate: FeedViewControllerDelegate?

    let viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tweets"

        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self,
                                           action: #selector(goToSearch))

        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton

        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)

        viewModel.state.bind { state in
            guard let state = state else { return }
            switch state {
            case .loading:
                break
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure:
                break
            }
        }

        viewModel.getTweets()
    }

    @objc func goToSearch() {
        delegate?.goToSearch()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? TweetCell,
              viewModel.tweetsCount > 0 else { return TweetCell() }

        let item = viewModel.getItem(at: indexPath.row)
        cell.configure(name: item.userName, username: item.screenName, text: item.content)
        return cell
    }
}
