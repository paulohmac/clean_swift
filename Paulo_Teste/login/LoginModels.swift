//
//  Models de autenticação
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


enum Authentication
{
  // MARK: Use cases
  
  enum Login
  {
    struct Request : Codable
    {
        var user: String
        var password: String
    }
    struct Response
    {
        var userAccount :UserAccount?
        var error = ""
    }

    struct ViewModel
    {
        var userId: String
        var name: String
        var bankAccount: String
        var agency: String
        var balance: String
    }
  }
}
