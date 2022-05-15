//
//  TrxApi.swift
//  YeAppIOS
//
//  Created by bigsur on 15.05.2022.
//

import Foundation

struct TrxApi : Decodable {
    let data : [ResultItem]
}

struct ResultItem : Decodable{
    let contractData : ContractData
}

struct ContractData : Decodable {
    let amount: Int
    let owner_address : String
    let to_address : String
}
