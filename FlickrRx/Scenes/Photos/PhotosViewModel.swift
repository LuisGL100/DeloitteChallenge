//
//  PhotosViewModel.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxSwift
import XCoordinator

protocol PhotosViewModelInput {
    var searchKeyword: AnyObserver<String> { get }
    var isNearBottom: AnyObserver<Bool> { get }
}

protocol PhotosViewModelOutput {
    var dataSource: Observable<[Photo]> { get }
}

protocol PhotosViewModel {
    var input: PhotosViewModelInput { get }
    var output: PhotosViewModelOutput { get }
}

extension PhotosViewModel where Self: PhotosViewModelInput {
    var input: PhotosViewModelInput { return self }
}

extension PhotosViewModel where Self: PhotosViewModelOutput {
    var output: PhotosViewModelOutput { return self }
}
