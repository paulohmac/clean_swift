//
//  Enum para transporte do resultado da API
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 07/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

 
enum Result<T> {
    case Success(T)
    case Failure(Error)
    
    func associatedValue() -> Any {
        switch self {
        case .Success(let value):
            return value
        case .Failure(let value):
            return value
        }
    }
}
