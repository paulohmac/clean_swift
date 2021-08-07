//
//  Interactor da classe de login
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


// MARK: - Interface
protocol LoginInteractorLogic
{
    //Faz a chamada ao worker
    func login(request : Authentication.Login.Request)
}

protocol LoginDataStore {
    var title: String { get }
}



// MARK: - Implementação
class LoginInteractor: LoginInteractorLogic, LoginDataStore{
    var title: String = ""
    
    var presenter: LoginPresenterLogic?
    var loginWorker = LoginWorker(auth: AutenticationAPI())
    
    init(){
    }
    
    func login(request : Authentication.Login.Request){
        if (validate(request)){
            loginWorker.login(request: request, { result -> Void in
                if let data = result.userAccount {
                    let responseData = Authentication.Login.Response(userAccount: data)
                    self.presenter?.presenteLogin(response: responseData)
                }else if let erro = result.error{
                    let response = Authentication.Login.Response(userAccount: nil, error: erro["message"] ?? "")
                    self.presenter?.presenteError(response: response)
                }
            })
        }else{
            self.presenter?.presenteValidateError(msg:  "Preencha senha e usuário")
        }
    }
    /// valida se os dados preenchidos estão corretos na viewcontroller
    ///
    /// - Parameter subject: Request com dados do viewcontroller.
    /// - Returns: true se os dados estão preenchidos
    private func validate(_ request : Authentication.Login.Request)->Bool{
        if request.user == "" || request.password == ""{
            return false
        }
        return true
    }

}

