//
//  SignInViewModel.swift
//  EsaNotes
//
//

import Foundation
import Combine
import AuthenticationServices

class SignInViewModel: NSObject, ObservableObject {
  @Published var isShowingSignInView = false
  @Published private(set) var isLoading = false

  func signIn() {
    guard let signInURL =
      NetworkRequest.RequestType.signIn.networkRequest()?.url
    else {
      print("Could not create the sign in URL .")
      return
    }

    let callbackURLScheme = NetworkRequest.callbackURLScheme
    let authenticationSession = ASWebAuthenticationSession(
      url: signInURL,
      callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
      guard
        error == nil,
        let callbackURL = callbackURL,
        let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
        let code = queryItems.first(where: { $0.name == "code" })?.value,
        let networkRequest =
          NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
      else {
        print("An error occurred when attempting to sign in.")
        return
      }

      self?.isLoading = true
      networkRequest.start(responseType: AuthorizeToken.self) { result in
        switch result {
        case .success:
          self?.getUser()
        case .failure(let error):
          print("Failed to exchange access code for tokens: \(error)")
          self?.isLoading = false
        }
      }
    }

    authenticationSession.presentationContextProvider = self
    authenticationSession.prefersEphemeralWebBrowserSession = true

    if !authenticationSession.start() {
      print("Failed to start ASWebAuthenticationSession")
    }
  }

  func appeared() {
    getUser()
  }

  private func getUser() {
    isLoading = true

    NetworkRequest
      .RequestType
      .getUser
      .networkRequest()?
      .start(responseType: User.self) { [weak self] result in
        switch result {
        case .success:
          self?.isShowingSignInView = true
        case .failure(let error):
          print("Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
        }
        self?.isLoading = false
      }
  }
}

extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession)
  -> ASPresentationAnchor {
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}
