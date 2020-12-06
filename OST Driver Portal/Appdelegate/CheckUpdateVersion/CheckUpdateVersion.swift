//
//  CheckUpdateVersion.swift
//  OST Driver Portal
//
//  Created by Ashok Kumar on 03/10/20.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class VersionCheck {

  public static let shared = VersionCheck()

    var newVersionAvailable: Bool?
    var appStoreVersion: String?

    func checkAppStore(callback: ((_ versionAvailable: Bool?, _ version: String?)->Void)? = nil) {
        let ourBundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        Alamofire.request("https://itunes.apple.com/lookup?bundleId=\(ourBundleId)").responseJSON { response in
            var isNew: Bool?
            var versionStr: String?

            if let json = response.result.value as? NSDictionary,
               let results = json["results"] as? NSArray,
               let entry = results.firstObject as? NSDictionary,
               let appVersion = entry["version"] as? String,
               let ourVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            {
                isNew = ourVersion != appVersion
                versionStr = appVersion
            }

            self.appStoreVersion = versionStr
            self.newVersionAvailable = isNew
            callback?(isNew, versionStr)
        }
    }
    
  func isUpdateAvailable(callback: @escaping (Bool)->Void) {
    let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    Alamofire.request("https://itunes.apple.com/lookup?bundleId=\(bundleId)").responseJSON { response in
      if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let versionStore = entry["version"] as? String, let versionLocal = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        let arrayStore = versionStore.split(separator: ".")
        let arrayLocal = versionLocal.split(separator: ".")

        if arrayLocal.count != arrayStore.count {
          callback(true) // different versioning system
        }

        // check each segment of the version
        for (key, value) in arrayLocal.enumerated() {
          if Int(value)! < Int(arrayStore[key])! {
            callback(true)
          }
        }
      }
      callback(false) // no new version or failed to fetch app store version
    }
  }
    
    func getAppInfo(completion: @escaping (AppInfo?, Error?) -> Void) -> URLSessionDataTask? {
        guard let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                DispatchQueue.main.async {
                    completion(nil, VersionError.invalidBundleInfo)
                }
                return nil
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let result = try JSONDecoder().decode(LookupResult.self, from: data)
                guard let info = result.results.first else { throw VersionError.invalidResponse }

                completion(info, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }

    enum VersionError: Error {
        case invalidBundleInfo, invalidResponse
    }

}


class LookupResult: Decodable {
    var results: [AppInfo]
}

class AppInfo: Decodable {
    var version: String
}
