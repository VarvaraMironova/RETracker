//
//  ZTSearchPropertiesContext.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 23.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

extension ZTSearchPropertiesContext {
    enum ZTSearchPropertiesContextState {
        case created
        case searching
        case failed
        case finished
        case cancelled
    }
}

class ZTSearchPropertiesContext: NSObject {
    lazy var searchSettings : ZTSearchSettings = {
        return ZTSearchSettings()
    }()
    
    var state : ZTSearchPropertiesContextState = .created
    
    private var client : ZTClient?
    
    //MARK:- Public
    public func perform(completion: @escaping ([ZTEvaluatedModel]?, NSError?) -> Void) {
        let client = ZTClient()
        state = .searching
        
        client.performSearch(searchSettings: searchSettings) { (property, error) in
            if let error = error {
                completion(nil, error)
                self.state = .failed
                self.client = nil
                
                return
            }
            
            var result = nil as [ZTEvaluatedModel]?
            
            if let property = property {
                result = property.evaluate()
            }
            
            if let result = result, result.count > 0 {
                self.state = .finished
                
                completion(result, nil)
            } else {
                let domain = ZTContextConstants.errorDomain ?? ZTContextConstants.errorDomain_undefined
                let error = NSError(domain   : domain,
                                    code     : ZTContextConstants.noResultsErrorCode,
                                    userInfo : ZTContextConstants.noResultsErrorUserInfo)
                self.state = .failed
                
                completion(nil, error)
            }
            
            self.client = nil
        }
        
        self.client = client
    }
    
    public func cancel() {
        if let client = client {
            client.cancel()
            state = .cancelled
            
            self.client = nil
        }
    }
}
