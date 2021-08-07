//
//  Worker tela principal
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

class MainWorker: NSObject {
    //Protocolo da Api de autenticação
    var auth: AuthenticationProtocol
    //Constructor
    init(auth: AuthenticationProtocol) {
        self.auth = auth
    }
    /// Envia requisição para a API
    ///
    /// - Parameter request: dados do usuário logado atualmente.
    /// - Parameter completionHandler: chamado ao receber retorno da api

    func listStatements(request: ListStatement.List.Request,_ completionHandler: @escaping (StatementList) -> Void)
    {
        auth.listStatements(request: request , { result  in
            //Api retorno objeto tipo Result que pode conter os dados ou um erro
            //baseado no type faz o retorno de um ou outro
            if let remoteData = result.associatedValue() as? StatementList {
                completionHandler(remoteData)
            }else  if let erroData = result.associatedValue() as? Error {
                var stateMentRet =  StatementList(statementList: [], error: ["error" :erroData.localizedDescription])
                completionHandler(stateMentRet)
            }
        })
    }
}

