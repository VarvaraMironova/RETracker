//
//  ZTTableViewDataSource.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 13.06.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import ZTModels

class ZTTableViewDataSource: NSObject, UITableViewDataSource {
    var models : [ZTEvaluatedModel]
    
    init(models: [ZTEvaluatedModel]) {
        self.models = models
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZTPropertyTableViewCell", for: indexPath) as! ZTPropertyTableViewCell
        let model = models[indexPath.row]
        cell.fillWithModel(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
}
