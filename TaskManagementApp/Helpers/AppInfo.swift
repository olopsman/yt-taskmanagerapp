//
//  AppInfo.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 10/12/2024.
//

import Foundation

struct AppInfo {

    static var appName : String {
        return readFromInfoPlist(withKey: "CFBundleDisplayName") ?? "(unknown app name)"
    }

    static var version : String {
        return readFromInfoPlist(withKey: "CFBundleShortVersionString") ?? "(unknown app version)"
    }

    static var build : String {
        return readFromInfoPlist(withKey: "CFBundleVersion") ?? "(unknown build number)"
    }

    static var minimumOSVersion : String {
        return readFromInfoPlist(withKey: "MinimumOSVersion") ?? "(unknown minimum OSVersion)"
    }

    static var copyrightNotice : String {
        return readFromInfoPlist(withKey: "NSHumanReadableCopyright") ?? "(unknown copyright notice)"
    }

    static var bundleIdentifier : String {
        return readFromInfoPlist(withKey: "CFBundleIdentifier") ?? "(unknown bundle identifier)"
    }

    static var developer : String { return "Paulo Orquillo" }

    static var company : String { return "Quonsepto Limited" }

    // lets hold a reference to the Info.plist of the app as Dictionary
    private static let infoPlistDictionary = Bundle.main.infoDictionary

    /// Retrieves and returns associated values (of Type String) from info.Plist of the app.
    private static func readFromInfoPlist(withKey key: String) -> String? {
        return infoPlistDictionary?[key] as? String
    }

}
