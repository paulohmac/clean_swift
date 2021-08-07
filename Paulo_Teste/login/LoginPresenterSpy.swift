//
//  Classe para teste do Interactor de Login
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 14/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

class LoginPresenterSpy: LoginPresenterLogic {

    var viewController : LoginViewControllerLogic?
    var success = false
    var completionHandler : ((Bool)->Void)?
    
    func presenteLogin(response : Authentication.Login.Response){
        if let breturn = response.userAccount?.name {
            success = true
            completionHandler!(true)
        }
    }
    
    func presenteError(response : Authentication.Login.Response){

    }
    
    func presenteValidateError(msg : String){

    }

}
