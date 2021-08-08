//
//  FlickrService.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol FlickrService {
    func photoSearch(for keyword: String) -> Observable<PageAPIModel>
    func photoSearch(for keyword: String, page: UInt) -> Observable<PageAPIModel>
    func photoSearch(for keyword: String, page: UInt, perPage: UInt) -> Observable<PageAPIModel>
}

class FlickrServiceImpl: FlickrService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func photoSearch(for keyword: String) -> Observable<PageAPIModel> {
        return photoSearch(for: keyword, page: 1, perPage: 100)
    }
    
    func photoSearch(for keyword: String, page: UInt) -> Observable<PageAPIModel> {
        return photoSearch(for: keyword, page: page, perPage: 100)
    }
    
    func photoSearch(for keyword: String, page: UInt, perPage: UInt) -> Observable<PageAPIModel> {
        guard !keyword.isEmpty else {
            return Observable.just(PageAPIModel(number: 1, totalPages: 1, photosPerPage: 100, totalPhotos: 0, photos: []))
        }
        let request = URLRequest(url: URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Environment.apiKey)&text=\(keyword)&page=\(page)&perpage=\(perPage)&format=json&nojsoncallback=1")!)
        return session.rx.data(request: request).map { (data) in
            try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
        }.map { (response) in
            response.page
        }.observeOn(MainScheduler.asyncInstance)
    }
}

class MockFlickrService: FlickrService {
    
    func photoSearch(for keyword: String) -> Observable<PageAPIModel> {
        return photoSearch(for: keyword, page: 1, perPage: 100)
    }
    
    func photoSearch(for keyword: String, page: UInt) -> Observable<PageAPIModel> {
        return photoSearch(for: keyword, page: page, perPage: 100)
    }
    
    func photoSearch(for keyword: String, page: UInt, perPage: UInt) -> Observable<PageAPIModel> {
        return Observable.just(PageAPIModel(number: 1, totalPages: 1, photosPerPage: 100, totalPhotos: 2, photos: [
            PhotoAPIModel(id: "a", owner: "x", secret: "c", server: "d", farm: 1, title: "Foo"),
            PhotoAPIModel(id: "b", owner: "x", secret: "c", server: "d", farm: 1, title: "Bar")
        ]))
    }
}
