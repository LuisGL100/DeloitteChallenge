//
//  PhotoAPIModel.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import Foundation

struct PhotoSearchResponse: Decodable {
    let page: PageAPIModel
    
    enum CodingKeys: String, CodingKey {
        case page = "photos"
    }
}

struct PageAPIModel: Decodable {
    let number: Int
    let totalPages: Int
    let photosPerPage: Int
    let totalPhotos: Int
    let photos: [PhotoAPIModel]
    
    enum CodingKeys: String, CodingKey {
        case number = "page"
        case totalPages = "pages"
        case photosPerPage = "perpage"
        case totalPhotos = "total"
        case photos = "photo"
    }
}

struct PhotoAPIModel: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    
    var url: URL? {
        let strUrl = "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        guard let url = URL(string: strUrl) else { return nil }
        return url
    }
}
