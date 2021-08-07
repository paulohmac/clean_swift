//
//  Models das APIS
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 08/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


struct StatementList : Codable {
    var  statementList :[Statement]
    var error  : [String : String]?
}

struct Statement: Codable {
    var title : String =  ""
    var desc : String =  ""
    var date : String  =  ""
    var value  : Float = 0.0
}
