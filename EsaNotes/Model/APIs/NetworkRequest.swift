//
//  NetworkRequest.swift
//  EsaNotes
//
//

import Foundation

struct NetworkRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    enum RequestError: Error {
        case invalidResponse
        case networkCreationError
        case sessionExpired
        case otherError(error: Error?)
        case decodeError(json: String)
    }

    func urlComponents(host: String = "api.esa.io", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
        switch self {
        default:
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = queryItems
            return urlComponents
        }
    }

    func start<T: Decodable> (
        path: String,
        queryItems: [URLQueryItem]? = nil,
        method: HTTPMethod
    ) async throws -> T {
        guard let url = urlComponents(path: path, queryItems: queryItems).url
        else {
            throw NetworkRequest.RequestError.networkCreationError
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let accessToken = SharedData.shared.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw NetworkRequest.RequestError.invalidResponse
              }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch let jsonError as NSError {
            throw NetworkRequest.RequestError.decodeError(json: jsonError.localizedDescription)
        } catch {
            throw NetworkRequest.RequestError.otherError(error: nil)
        }
    }
}
