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
    func lognIn() async throws {
        guard let logInURL =
                NetworkRequest.RequestType.logIn.networkRequest()?.url
        else {
            print("Could not create the sign in URL .")
            return
        }

        let callbackURLScheme = NetworkRequest.callbackURLScheme

        do {
            let callbackURL = try await authenticate(logInURL: logInURL, callbackURLScheme: callbackURLScheme)
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let code = queryItems?.first(where: { $0.name == "code" })?.value ?? ""
            let networkRequest = NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
            let authorization = try await getAccessToken(request: networkRequest)
            SharedData.shared.accessToken = authorization.accessToken
        } catch {
            print(error)
        }
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
                print("Failed to start ASWebAuthenticationSession")
            }
        }
    }

    private func getAccessToken(request: NetworkRequest?) async throws -> AuthorizeToken {
        try await withCheckedThrowingContinuation { continuation in
            guard let request = request else {
                print("No NetworkRequest")
                fatalError()
            }
            request.start(responseType: AuthorizeToken.self) { result in
                switch result {
                case .success(let (_ , object)):
                    continuation.resume(with: .success(object))
                case .failure(let error):
                    print("Failed to exchange access code for tokens: \(error)")
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }

    func setUserData(user: User) {
        SharedData.shared.isLoggedIn = true
        SharedData.shared.userName = user.name
        SharedData.shared.screenName = user.screenName
        SharedData.shared.icon = user.icon
        SharedData.shared.email = user.email
    }

    private func getUser() {
        SharedData.shared.isLoading = true
        NetworkRequest
            .RequestType
            .getUser
            .networkRequest()?
            .start(responseType: User.self) { [weak self] result in
                switch result {
                case .success(let (_, object)):
                    self?.setUserData(user: object)
                case .failure(let error):
                    print("Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
                SharedData.shared.isLoading = false
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
