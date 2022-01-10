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
        case otherError
        case sessionExpired
        case decodeError
    }

    enum RequestType: Equatable {
        case codeExchange(code: String)
        case getUser
        case signIn

        func networkRequest() -> NetworkRequest? {
            guard let url = url() else {
                return nil
            }
            return NetworkRequest(method: httpMethod(), url: url)
        }

        private func httpMethod() -> NetworkRequest.HTTPMethod {
            switch self {
            case .codeExchange:
                return .post
            case .getUser:
                return .get
            case .signIn:
                return .get
            }
        }

        private func url() -> URL? {
            switch self {
            case .codeExchange(let code):
                let queryItems =
                [
                    "client_id": NetworkRequest.clientID,
                    "client_secret": NetworkRequest.clientSecret,
                    "code": code,
                    "grant_type": "authorization_code",
                    "redirect_uri": "esanote://oauth-callback"
                ].map { URLQueryItem(name: $0, value: $1) }
                return urlComponents(path: "/oauth/token", queryItems: queryItems).url
            case .getUser:
                return urlComponents(path: "/v1/user", queryItems: nil).url
            case .signIn:
                let queryItems =
                [
                    "client_id": NetworkRequest.clientID,
                    "redirect_uri": "esanote://oauth-callback",
                    "scope": "read+write",
                    "response_type": "code",
                    "state": "a7e567e2fb858f0e12838798016ee9cf8ccc778"
                ].map { URLQueryItem(name: $0, value: $1) }
                return urlComponents(path: "/oauth/authorize", queryItems: queryItems).url
            }
        }

        // swiftlint:disable:next line_length
        private func urlComponents(host: String = "api.esa.io", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
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
    }

    typealias NetworkResult<T: Decodable> = (response: HTTPURLResponse, object: T)

    // MARK: Private Constants
    static let callbackURLScheme = "esanote"
    static let clientID = APIClientKey.clientID
    static let clientSecret = APIClientKey.clientSecret

    // MARK: Properties
    var method: HTTPMethod
    var url: URL

    // MARK: Static Methods
    static func signOut() {
        Self.accessToken = ""
        Self.refreshToken = ""
        Self.username = ""
    }

    // MARK: Methods
    // swiftlint:disable:next function_body_length
    func start<T: Decodable>(
        responseType: T.Type,
        completionHandler: @escaping ((Result<NetworkResult<T>, Error>) -> Void)
    ) {
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = method.rawValue
        if let accessToken = NetworkRequest.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(RequestError.invalidResponse))
                }
                return
            }
            guard error == nil, let data = data
            else {
                DispatchQueue.main.async {
                    let error = error ?? NetworkRequest.RequestError.otherError
                    completionHandler(.failure(error))
                }
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    if let user = object as? User {
                        NetworkRequest.username = user.name
                    } else if let token = object as? AuthorizeToken {
                        NetworkRequest.accessToken = token.accessToken
                    }
                    completionHandler(.success((response, object)))
                }
                return
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                completionHandler(.failure(NetworkRequest.RequestError.decodeError))
            } catch {
                completionHandler(.failure(NetworkRequest.RequestError.otherError))
            }
        }
        session.resume()
    }
}
