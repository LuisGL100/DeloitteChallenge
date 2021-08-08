//
//  AppCoordinator.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case photos
    case photoDetail
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .photos)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .photos:
            let viewController = PhotosViewController.instantiateFromNib()
            let viewModel = PhotosViewModelImpl()
            viewController.bind(to: viewModel)
            return .push(viewController)
        case .photoDetail: fatalError()
        }
    }
}
