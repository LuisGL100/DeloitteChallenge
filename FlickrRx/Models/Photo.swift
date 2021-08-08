//
//  Photo.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import Foundation

struct Photo {
    let title: String
    let url: URL
}

extension PhotoAPIModel {
    func toPhoto() -> Photo? {
        guard let url = url else { return nil }
        return Photo(title: title, url: url)
    }
}
