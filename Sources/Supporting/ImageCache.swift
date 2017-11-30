//
//  ImageCache.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 30/11/2017.
//  Solution: https://github.com/MessageKit/MessageKit/issues/164#issuecomment-332330538

import UIKit

final class ImageCache {

    private init() { }

    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    func set(key: String, image: UIImage) {
        DispatchQueue.main.sync {
            cache.setObject(image, forKey: key as NSString)
        }
    }

    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
