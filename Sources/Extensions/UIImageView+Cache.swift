//
//  UIImageView+Cache.swift
//  MessageKit
//
//  Created by Luqman Fauzi on 30/11/2017.
//  Solution: https://github.com/MessageKit/MessageKit/issues/164#issuecomment-332330538

import Foundation

public extension UIImageView {

    func downloadImageAsync(url: URL, defaultImage: UIImage = UIImage(), completion: (() -> Void)?) {
        let urlString = url.absoluteString
        if let image = ImageCache.shared.get(key: urlString) {
            completion?()
            self.image = image
        } else {
            // We can set default image here
            self.image = defaultImage
            DispatchQueue.global().async (execute: {
                guard let url = URL(string: urlString) else {
                    DispatchQueue.main.sync(execute: {
                        completion?()
                    })
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.sync(execute: {
                        completion?()
                    })
                    return
                }
                guard let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.set(key: urlString, image: image)
                DispatchQueue.main.sync (execute: {
                    self.image = image
                    completion?()
                })
            })
        }
    }
}
