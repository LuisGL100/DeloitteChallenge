//
//  Environment.swift
//  FlickrRx
//
//  Created by Luis López on 8/8/21.
//

import Foundation

public enum Environment {
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              key.count > 0 else {
            fatalError("""
                Flickr API Key not found. Please create a
                'Secrets.xcconfig' file under 'FlickRx/Common' and add:
                FLICKR_SECRET_KEY = YOUR_FLICKR_API_KEY
                """)
        }
        return key
    }()
}
