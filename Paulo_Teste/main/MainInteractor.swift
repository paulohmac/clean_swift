//
// interactor modulo principal
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

protocol MainInteractorLogic
{
    func loadData(request : ListStatement.List.Request)
}



class MainInteractor: MainInteractorLogic {
    var presenter: MainPresenterLogic?
    var mainWorker = MainWorker(auth: AutenticationAPI())
 
    init(){
    }
    
    /// faz chamada ao worker se retornar dados chama presenter, caso contrsario exibe erro
    ///
    /// - Parameter request: retorno da api.

    func loadData(request : ListStatement.List.Request){
        mainWorker.listStatements(request: request, { result -> Void in
            //Se
            if let data = result.statementList as? [Statement] {
                let responseData = ListStatement.List.Response(statementList: data, error: nil)
                self.presenter?.presenteList(response: responseData)
            }else if let erro = result.error{
                let response = ListStatement.List.Response(statementList:nil, error: erro)
            }
        })
    }

    
}
