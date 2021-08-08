//
//  PhotosViewModel.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import RxSwift
import XCoordinator

protocol PhotosViewModelInput {
    
}

protocol PhotosViewModelOutput {
    
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
