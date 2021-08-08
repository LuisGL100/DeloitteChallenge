//
//  PhotosViewController.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxCocoa
import RxSwift
import UIKit

class PhotosViewController: UIViewController {
    var viewModel: PhotosViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        
        let searchContoller = UISearchController(searchResultsController: nil)
        searchContoller.hidesNavigationBarDuringPresentation = true
        searchContoller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchContoller
    }
}

extension PhotosViewController: BindableType {
    func bindViewModel() {
        navigationItem.searchController?.searchBar
            .rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .bind(to: viewModel.input.searchKeyword)
            .disposed(by: disposeBag)
    }
}
