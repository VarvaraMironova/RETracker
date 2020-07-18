//
//  ZTSearchPropertiesContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTSearchPropertiesContext: NSObject {
    var parameters : [String : Any]?
    
    private var client : ZTClient?
    
    init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    public func perform(completion: @escaping ([ZTEvaluatedModel]?, NSError?) -> Void) {
        if let parameters = parameters {
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
                    //schedule notifications
                    let notificationContext = ZTLocalNotificationContext.init(properties: result)
                    notificationContext.run()
                    
                    completion(result, nil)
                } else {
                    let error = NSError.init(domain   : ZTUIConstants.errorDomain ?? ZTUIConstants.errorDomain_undefined,
                                             code     : ZTUIConstants.noResultsErrorCode,
                                             userInfo : ZTUIConstants.noResultsErrorUserInfo)
                    completion(nil, error)
                }
            }
            
            self.client = client
        }
    }
    
    public func cancel() {
        if let client = client {
            client.cancel()
            
            self.client = nil
        }
    }
}
