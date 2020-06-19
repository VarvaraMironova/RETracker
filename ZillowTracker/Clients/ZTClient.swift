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
    
    func performSearch(parameters: [String:Any], completion: @escaping (ZTProperties?, NSError?) -> Void) {
        let parameters: Parameters = parameters.merging(ZTConstants.defaultSearchParameters)
        { (current, _) in current }
        
        let headers: HTTPHeaders = ZTConstants.defaultRealtorAPIHeaders
        
        Alamofire.request(ZTConstants.realtorAPIForSale, method: .get, parameters: parameters, headers: headers).downloadProgress { (bytesRead) in
            
        }
        
        Alamofire.request(
            ZTConstants.realtorAPIForSale,
            method    : .get,
            parameters: parameters,
            headers   : headers).validate().responseData { response in
                if response.result.isFailure {
                    if let error = response.error {
                        //https://stackoverflow.com/questions/51602907/why-can-any-error-be-unconditionally-converted-to-nserror
                        completion(nil, error as NSError)
                    } else {
                        let error = NSError.init(domain   : ZTConstants.errorDomain ?? ZTConstants.errorDomain_undefined,
                                                 code     : NSURLErrorBadServerResponse,
                                                 userInfo : ZTConstants.responseErrorUserInfo)
                        completion(nil, error)
                    }
                    
                    return
                }

                guard let jsonData = response.result.value else {
                    let error = NSError.init(domain   : ZTConstants.errorDomain ?? ZTConstants.errorDomain_undefined,
                                             code     : ZTConstants.parsingErrorCode,
                                             userInfo : ZTConstants.parsingErrorUserInfo)
                    completion(nil, error)

                    return
                }
            
                let decoder = JSONDecoder()
                
                if let properties = try? decoder.decode(ZTProperties.self, from: jsonData) {
                    completion(properties, nil)
                } else {
                    let error = NSError.init(domain   : ZTConstants.errorDomain ?? ZTConstants.errorDomain_undefined,
                                             code     : ZTConstants.mappingErrorCode,
                                             userInfo : ZTConstants.mappingErrorUserInfo)
                    completion(nil, error)
                }
        }
    }
    
    private func debugMapping(jsonData: Data) {
        do {
            if let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                if let properties = result["properties"] as? [[String : Any]] {
                    for propertyItem in properties {
                        print("identifier: ", propertyItem[ZTHouse.CodingKeys.identifier.rawValue] ?? "--")
                        print("link: ", propertyItem[ZTHouse.CodingKeys.link.rawValue] ?? "--")
                        print("address: ", propertyItem[ZTHouse.CodingKeys.address.rawValue] ?? "--")
                        print("price: ", propertyItem[ZTHouse.CodingKeys.price.rawValue] ?? "--")
                        print("baths: ", propertyItem[ZTHouse.CodingKeys.baths.rawValue] ?? "--")
                        print("beds: ", propertyItem[ZTHouse.CodingKeys.beds.rawValue] ?? "--")
                        print("area: ", propertyItem[ZTHouse.CodingKeys.area.rawValue] ?? "--")
                        print("lot: ", propertyItem[ZTHouse.CodingKeys.lot.rawValue] ?? "--")
                        print("propertyType: ", propertyItem[ZTHouse.CodingKeys.propertyType.rawValue] ?? "--")
                        print("thumbnail: ", propertyItem[ZTHouse.CodingKeys.thumbnail.rawValue] ?? "--")
                        print("lastUpdate: ", propertyItem[ZTHouse.CodingKeys.lastUpdate.rawValue] ?? "--")
                    }
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
