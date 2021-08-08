//
//  PhotosViewController.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxCocoa
import RxSwift
import UIKit
import Kingfisher

class PhotosViewController: UIViewController {
    var viewModel: PhotosViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        
        let searchContoller = UISearchController(searchResultsController: nil)
        searchContoller.hidesNavigationBarDuringPresentation = true
        searchContoller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchContoller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
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
        
        viewModel.output.dataSource
            .bind(to: collectionView.rx.items(cellIdentifier: PhotoCell.reuseIdentifier, cellType: PhotoCell.self)) { (row, element, cell) in
                cell.imageView?.kf.setImage(with: element.url, placeholder: UIImage(systemName: "hare"), options: [.scaleFactor(UIScreen.main.scale), .cacheOriginalImage])
                cell.imageView?.contentMode = .scaleAspectFit
            }
            .disposed(by: disposeBag)
        
        viewModel.output.dataSource.subscribe(onNext: { [weak self] _ in
            self?.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        })
        .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset.flatMap { [weak self] (offset) -> Observable<Bool> in
            guard let collectionView = self?.collectionView else { return Observable.empty() }
            let contentSizeHeight = collectionView.contentSize.height
            let shouldTrigger = (contentSizeHeight > 0) && (offset.y + collectionView.bounds.height + 50 > contentSizeHeight)
            return shouldTrigger ? Observable.just(true) : Observable.empty()
        }
        .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
        .bind(to: viewModel.input.isNearBottom)
        .disposed(by: disposeBag)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 30) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
