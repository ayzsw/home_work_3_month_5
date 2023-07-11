//
//  ImageDownloader.swift
//  home_work_2_month_5
//
//  Created by Аяз on 30/6/23.
//

import UIKit

enum ImageDownloader {
    static func downloadImage(with url: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let url = URL(string: url)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData = try? Data(contentsOf: url!)
            guard let imageData else {
                return
            }
            let image = UIImage(data: imageData)
            completion(.success(image))
            
        }
    }
}
