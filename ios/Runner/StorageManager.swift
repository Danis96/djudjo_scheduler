//
//  StorageManager.swift
//  Runner
//
//  Created by Emir Hamidovic on 17/09/2020.
//

@propertyWrapper
struct StorageWrapper<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Store to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
