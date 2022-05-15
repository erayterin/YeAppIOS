//
//  WebService.swift
//  YeAppIOS
//
//  Created by bigsur on 15.05.2022.
//

import Foundation

class WebService {
    
    func getTrxApi(url: URL, completion: @escaping (TrxApi?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                
                let trxDataList = try? JSONDecoder().decode(TrxApi.self, from: data)
                
                if let trxDataList = trxDataList {
                    completion(trxDataList)
                } 
            }
        }.resume()
        
    }
}
