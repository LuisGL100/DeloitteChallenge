//
//  PhotosViewModelImpl.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxSwift
import XCoordinator
import XCoordinatorRx

class PhotosViewModelImpl: PhotosViewModel, PhotosViewModelInput, PhotosViewModelOutput {
    private let service: FlickrService
    private let disposeBag = DisposeBag()
    
    var searchKeyword: AnyObserver<String> {
        searchAction.asObserver()
    }
    private lazy var searchAction = BehaviorSubject<String>(value: "")
    
    private lazy var blah = BehaviorSubject<String>(value: "")
    
    var isNearBottom: AnyObserver<Bool> {
        loadNextPage.asObserver()
    }
    private lazy var loadNextPage = PublishSubject<Bool>()
    
    var dataSource: Observable<[Photo]> {
        photos.asObservable()
    }
    private lazy var photos = PublishSubject<[Photo]>()
    
    private var page: PageAPIModel?
    
    init(service: FlickrService) {
        self.service = service
        
        searchAction.skip(1).subscribe(onNext: { [weak self] (keyword) in
            self?.fetchPhotos(for: keyword, page: 1)
        })
        .disposed(by: disposeBag)
        
        loadNextPage
            .distinctUntilChanged()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (load) in
                guard let self = self, load else { return }
                print("Load next page: \(load)")
                let pageToLoad: UInt
                if let page = self.page {
                    pageToLoad = UInt(page.number + 1)
                } else {
                    pageToLoad = 1
                }
                let keyword = try! self.searchAction.value()
                self.fetchPhotos(for: keyword, page: pageToLoad)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchPhotos(for keyword: String, page: UInt) {
        service.photoSearch(for: keyword, page: page).bind { [weak self] (page) in
            let photos: [Photo] = page.photos.compactMap { (photo) in
                return photo.toPhoto()
            }
            self?.page = page
            self?.photos.onNext(photos)
            self?.loadNextPage.onNext(false)
        }
        .disposed(by: disposeBag)
    }
}
