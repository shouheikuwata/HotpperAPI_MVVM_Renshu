//
//  ImageDownloader.swift
//  HotppepperAPISample
//
//  Created by 桑田翔平 on 2022/06/20.
//

import UIKit
import Foundation

final class ImageDownloader {

    var catchImage: UIImage?

    func downloadImge(imageURL: String, handler: @escaping ResultHandler<UIImage>) {
        if let catchImage = catchImage {
            handler(.success(catchImage))
        }
        var request = URLRequest(url: URL(string: imageURL)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(.failure(APIError.unknown))
                }
                return
            }
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    handler(.failure(APIError.unknown))
                }
                return
            }
            DispatchQueue.main.async {
                handler(.success(imageFromData))
            }
            self.catchImage = imageFromData
        }
        task.resume()
    }

}
