//
//  QUser.swift
//  Qwift
//
//  Created by Student on 12/30/21.
//

import Foundation

struct QUser{
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
