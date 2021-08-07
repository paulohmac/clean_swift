//
//  Models das APIS de login
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 05/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

struct Login: Codable {
    var userAccount :  UserAccount?
    var error  : [String : String]?
}

struct UserAccount : Codable {
    var userId : Int
    var name : String
    var bankAccount : String
    var balance : Float
    var agency : String
}
