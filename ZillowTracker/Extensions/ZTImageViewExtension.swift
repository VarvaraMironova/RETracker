//
//  ZTImageViewExtension.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 17.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        Alamofire.request(urlString, method: .get)
        .validate()
        .responseData(completionHandler: { (responseData) in
            if let data = responseData.data {
                self.image = UIImage(data: data)
            }
        })
    }
}
