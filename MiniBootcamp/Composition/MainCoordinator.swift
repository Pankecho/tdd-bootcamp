//
//  MainCoordinator.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var viewControllerFactory: ViewControllerFactory
    
    init(rootViewController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.rootViewController = rootViewController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        guard let vc = viewControllerFactory.feedViewController() as? FeedViewController else { return }
        vc.delegate = self
        rootViewController.pushViewController(vc, animated: false)
    }

    func pushSearchViewController() {
        rootViewController.pushViewController(viewControllerFactory.searchViewController(), animated: false)
    }
}

extension MainCoordinator: FeedViewControllerDelegate {
    func goToSearch() {
        pushSearchViewController()
    }
}
