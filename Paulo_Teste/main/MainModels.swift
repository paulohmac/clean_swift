//
//  Models view controller principal
//  trafega entre camadas
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

enum ListStatement
{
  // MARK: Use cases
  
  enum List
  {
    struct Request : Codable
    {
        var userId: String
    }
    struct Response
    {
        var statementList : [Statement]?
        var error  : [String : String]?
    }

    struct ViewModel
    {
        var statementList : [ViewModelStatement]
    }
    
    struct ViewModelStatement{
        var title: String
        var desc: String
        var date: String
        var value: String
    }
  }
}
