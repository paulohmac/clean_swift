//
//  Faz chamada a api de autenticação
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


class LoginWorker{
  var auth: AuthenticationProtocol
  
  init(auth: AuthenticationProtocol) {
    self.auth = auth
  }
  
  func login(request: Authentication.Login.Request,_ completionHandler: @escaping (Login) -> Void)
  {
    auth.login(request: request , { result  in
        if let remoteData = result.associatedValue() as? Login {
            completionHandler(remoteData)
        }else  if let erroData = result.associatedValue() as? Error {
            var loginRet =  Login()
            loginRet.error = ["error" :erroData.localizedDescription]
            completionHandler(loginRet)
        }
    })
  }
}



