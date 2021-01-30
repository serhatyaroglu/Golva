//
//  GolvaInfo.swift
//  Golva
//
//  Created by serhat yaroglu on 30.01.2021.
//

import Foundation
import Alamofire

struct ApiResult : Decodable {
    let metas:Meta
    let response:Response
}

struct Response :Decodable
{
    let contacts:[Contact]
}

struct Contact:Decodable {
  
    var turAdi:String
    let photo:String
    let turSaati:String
    
    init(turAdi:String,photo:String,turSaati:String) {
      
       
        self.turAdi = turAdi
        self.photo = photo

        self.turSaati = turSaati

    }
    
}

struct Meta : Decodable {
    let code:Int
}

public func getStringText() -> String{
    return "\(Contact.self)"
  }

