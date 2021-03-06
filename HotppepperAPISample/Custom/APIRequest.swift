//
//  APIRequest.swift
//  HotppepperAPISample
//
//  Created by 桑田翔平 on 2022/06/20.
//


import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void

enum APIError: Error, CustomStringConvertible  {
    case unknown
    case invalidURL
    case invalidResponse
    var description: String {
        switch self {
        case .unknown: return "不明なエラーです"
        case .invalidURL: return "無効なURLです"
        case .invalidResponse: return "フォーマットが無効なレスポンスを受け取りました"
        }
    }
}

final class API {

    func getUsers(handler: @escaping ResultHandler<[Shop]>) {
        
        let requestUrl = URL(string: "https://api.github.com/users")
        
        guard let url = requestUrl else {
            handler(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
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
            guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsons = jsonOptional as? [[String: Any]] else {
                DispatchQueue.main.async {
                    handler(.failure(APIError.invalidResponse))
                }
                return
            }
            var shops = [Shop]()
            jsons.forEach { json in
                let shop = Shop(attributes: json)
                shops.append(shop)
            }
            DispatchQueue.main.async {
                handler(.success(shops))
            }
        }
        task.resume()
    }

}
