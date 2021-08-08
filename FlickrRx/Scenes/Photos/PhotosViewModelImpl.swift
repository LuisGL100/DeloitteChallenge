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
    
    init(service: FlickrService) {
        self.service = service
        
        self.service.photoSearch(for: "abc").bind { (page) in
            page.photos.forEach { (photo) in
                print("Photo: \(photo.title)")
            }
        }
        .disposed(by: disposeBag)
    }
}
