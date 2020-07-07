//
//  ZTSearchPropertiesContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit

class ZTSearchPropertiesContext: NSObject {
    var maxPrice: Int
    var zip     : String
    
    private var client : ZTClient?
    
    init(maxPrice: Int, zip: String) {
        self.maxPrice = maxPrice
        self.zip = zip
    }
    
    public func perform(completion: @escaping ([ZTEvaluatedModel]?, NSError?) -> Void) {
        let parameters = [ZTConstants.maxPriceKey : maxPrice, ZTConstants.zipKey : zip] as [String : Any]
        
        let client = ZTClient()
        client.performSearch(parameters: parameters) { (property, error) in
            if let error = error {
                completion(nil, error)
                
                return
            }
            
            var result = nil as [ZTEvaluatedModel]?
            
            if let property = property {
                result = property.evaluate()
            }
            
            if let result = result, result.count > 0 {
                completion(result, nil)
            } else {
                let error = NSError.init(domain   : ZTConstants.errorDomain ?? ZTConstants.errorDomain_undefined,
                                         code     : ZTConstants.noResultsErrorCode,
                                         userInfo : ZTConstants.noResultsErrorUserInfo)
                completion(nil, error)
            }
        }
        
        self.client = client
    }
    
    public func cancel() {
        if let client = client {
            client.cancel()
            
            self.client = nil
        }
    }
}
