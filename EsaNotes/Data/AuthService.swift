//
//  AuthService.swift
//  EsaNotes
//
//  Created by taishi.kusunose on 2022/02/26.
//

import Foundation
import AuthenticationServices

final class AuthService: NSObject {
    var authenticationSession: ASWebAuthenticationSession!
    let callbackURLScheme = "esanote"
    let clientID = APIClientKey.clientID
    let clientSecret = APIClientKey.clientSecret
    let networkRequest = NetworkRequest()

    func lognIn() async throws {
        let path = "/oauth/authorize"
        let queryItems =
        [
            "client_id": clientID,
            "redirect_uri": "esanote://oauth-callback",
            "scope": "read+write",
            "response_type": "code",
            "state": "a7e567e2fb858f0e12838798016ee9cf8ccc778"
        ].map { URLQueryItem(name: $0, value: $1) }

        guard let logInURL = networkRequest.urlComponents(path: path, queryItems: queryItems).url
        else {
            throw NetworkRequest.RequestError.networkCreationError
        }
        let callbackURLScheme = callbackURLScheme

        do {
            let callbackURL = try await authenticate(logInURL: logInURL, callbackURLScheme: callbackURLScheme)
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let code = queryItems?.first(where: { $0.name == "code" })?.value ?? ""
            SharedData.shared.accessToken = try await getAuthorizeToken(code: code).accessToken
        } catch {
            print(error)
        }
    }

    private func getAuthorizeToken(code: String) async throws -> AuthorizeToken{
        let path = "/oauth/token"
        let queryItems =
        [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": "esanote://oauth-callback"
        ].map { URLQueryItem(name: $0, value: $1) }
        return try await networkRequest.start(path: path, queryItems: queryItems, method: .post)
    }

    private func authenticate(logInURL: URL, callbackURLScheme: String?) async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            authenticationSession = ASWebAuthenticationSession(
                url: logInURL,
                callbackURLScheme: callbackURLScheme) { callbackURL, error in
                    if let callbackURL = callbackURL {
                        continuation.resume(with: .success(callbackURL))
                    } else if let error = error {
                        continuation.resume(with: .failure(error))
                    } else {
                        fatalError()
                    }
                }
            authenticationSession.presentationContextProvider = self
            authenticationSession.prefersEphemeralWebBrowserSession = true

            if !authenticationSession.start() {
                continuation.resume(with: .failure(NetworkRequest.RequestError.otherError))
            }
        }
    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
