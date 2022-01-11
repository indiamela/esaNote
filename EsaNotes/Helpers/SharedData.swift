//
//  SharedData.swift
//  EsaNotes
//
//

import Foundation

final class SharedData {
    static let shared = SharedData()

    private let defaults: UserDefaults

    private init() {
        #if DEBUG
        self.defaults = UserDefaults(suiteName: "com.esanote.Debug")!
        #elseif TEST
        self.defaults = UserDefaults(suiteName: "com.esanote.Tests")!
        #else
        self.defaults = .standard
        #endif
    }

    func synchronize() {
        defaults.synchronize()
    }
}

// MARK: Account Info
extension DataStore {
    var isLoggedIn: Bool {
        get { bool("login") }
        set { set(newValue, forKey: "login") }
    }

    var accessToken: String? {
        get { string("access_token") }
        set { set(newValue, forKey: "access_token") }
    }

    var userName: String? {
        get { string("user_name") }
        set { set(newValue, forKey: "user_name") }
    }

    var screenName: String? {
        get { string("screen_name") }
        set { set(newValue, forKey: "screen_name") }
    }

    var icon: String? {
        get { string("icon") }
        set { set(newValue, forKey: "icon") }
    }

    var email: String? {
        get { string("email") }
        set { set(newValue, forKey: "email") }
    }

    func clearAccountInfo() {
        isLoggedIn = false
        accessToken = ""
        userName = ""
        screenName = ""
        icon = ""
        email = ""
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
}
