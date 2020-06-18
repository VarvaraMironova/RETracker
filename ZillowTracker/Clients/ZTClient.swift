//
//  ZTClient.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 5/31/20.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import Alamofire

class ZTClient: NSObject {
    
    func performSearch(parameters: [String:String], completion: @escaping (ZTProperties?) -> Void) {
        let parameters: Parameters = parameters.merging(ZTConstants.defaultSearchParameters)
        { (current, _) in current }
        
        let headers: HTTPHeaders = ZTConstants.defaultRealtorAPIHeaders
        
        Alamofire.request(ZTConstants.realtorAPIForSale, method: .get, parameters: parameters, headers: headers).downloadProgress { (bytesRead) in
            
        }
        
        Alamofire.request(ZTConstants.realtorAPIForSale,
                          method    : .get,
                          parameters: parameters,
                          headers   : headers).validate().responseData { response in
            if response.result.isFailure {
                completion(nil)

                return
            }

            guard let jsonData = response.result.value else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            if let properties = try? decoder.decode(ZTProperties.self, from: jsonData) {
                completion(properties)
            } else {
                print("mapping failed")
                completion(nil)
            }

        }
    }
    
    func writeToFile(data: Data) {
        if let directoryURL = getDocumentsDirectory() {
            let url = directoryURL.appendingPathComponent("response.json")
            print(url)
            
            do {
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func readFile() -> Data? {
        if let directoryURL = getDocumentsDirectory() {
            let url = directoryURL.appendingPathComponent("response.json")
            
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                return data
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return nil
    }
    
    func getDocumentsDirectory() -> URL? {
        return URL(string: "file:///Users/varvaramyronova/Library/Developer")
    }
    
}
