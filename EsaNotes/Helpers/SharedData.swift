//
//  SharedData.swift
//  EsaNotes
//
//

import Foundation
import KeychainAccess

final class SharedData {
    static let shared = SharedData()

    private let defaults: UserDefaults
    private let keychain: Keychain

    private init() {
        #if DEBUG
        self.defaults = UserDefaults(suiteName: "com.esanote.Debug")!
        self.keychain = Keychain(service: "com.esanote.Debug")
        #elseif TEST
        self.defaults = UserDefaults(suiteName: "com.esanote.Tests")!
        self.keychain = Keychain(service: "com.esanote.Tests")
        #else
        self.defaults = .standard
        self.keychain = Keychain()
        #endif
    }

    func synchronize() {
        defaults.synchronize()
    }
}

// MARK: Account Info
extension DataStore {
    var accessToken: String? {
        get { getKeychain("access_token") }
        set { setKeychain(newValue, forKey: "access_token") }
    }
}

extension DataStore {
    var isLoading: Bool {
        get { bool("loading") }
        set { set(newValue, forKey: "loading") }
    }
}

// MARK: - DataStore
protocol DataStore: AnyObject {
    func string(_ key: String) -> String?
    func integer(_ key: String) -> Int
    func integer64(_ key: String) -> Int64
    func bool(_ key: String) -> Bool
    func array(_ key: String) -> [Any]?
    func data(_ key: String) -> Data?
    func object(_ key: String) -> Any?
    func set(_ newValue: Any?, forKey: String)
    func removeObject(for key: String)
    func removeAllObjects()
    func getKeychain(_ key: String) -> String?
    func setKeychain(_ newValue: String?, forKey: String)
}

extension SharedData: DataStore {
    func string(_ key: String) -> String? {
        defaults.string(forKey: key)
    }

    func integer(_ key: String) -> Int {
        defaults.integer(forKey: key)
    }

    func integer64(_ key: String) -> Int64 {
        Int64(defaults.double(forKey: key))
    }

    func bool(_ key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func array(_ key: String) -> [Any]? {
        defaults.array(forKey: key)
    }

    func data(_ key: String) -> Data? {
        defaults.data(forKey: key)
    }

    func object(_ key: String) -> Any? {
        defaults.object(forKey: key)
    }

    func set(_ newValue: Any?, forKey: String) {
        defaults.set(newValue, forKey: forKey)
    }

    func removeObject(for key: String) {
        defaults.removeObject(forKey: key)
    }

    func removeAllObjects() {
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
    }

    func getKeychain(_ key: String) -> String? {
        try! keychain.getString(key)
    }

    func setKeychain(_ newValue: String?, forKey: String) {
        if let newValue = newValue {
            try! keychain.set(newValue, key: forKey)
        }
    }

}
