//
//  UIImage+Cache.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Foundation
import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSURL, UIImage>()

    func imageFrom(url: URL) {
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                UIImageView.imageCache.setObject(image, forKey: url as NSURL)

                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
