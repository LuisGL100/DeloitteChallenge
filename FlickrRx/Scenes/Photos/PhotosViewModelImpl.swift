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
    
    init(service: FlickrService) {
        self.service = service
        
        searchAction.subscribe(onNext: { [unowned self] (keyword) in
            self.fetchPhotos(for: keyword)
        })
        .disposed(by: disposeBag)
    }
    
    private func fetchPhotos(for keyword: String) {
        service.photoSearch(for: keyword).bind { (page) in
            page.photos.forEach { (photo) in
                print("Photo: \(photo.title)")
            }
        }
        .disposed(by: disposeBag)
    }
}
