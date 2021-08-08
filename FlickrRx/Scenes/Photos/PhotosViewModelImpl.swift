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
    private lazy var searchAction = PublishSubject<String>()
    
    var dataSource: Observable<[Photo]> {
        photos.asObservable()
    }
    private lazy var photos = PublishSubject<[Photo]>()
    
    init(service: FlickrService) {
        self.service = service
        
        searchAction.subscribe(onNext: { [weak self] (keyword) in
            self?.fetchPhotos(for: keyword)
        })
        .disposed(by: disposeBag)
    }
    
    private func fetchPhotos(for keyword: String) {
        service.photoSearch(for: keyword).bind { [weak self] (page) in
            let photos: [Photo] = page.photos.compactMap { (photo) in
                print("Photo: \(photo.title)")
                return photo.toPhoto()
            }
            self?.photos.onNext(photos)
        }
        .disposed(by: disposeBag)
    }
}
