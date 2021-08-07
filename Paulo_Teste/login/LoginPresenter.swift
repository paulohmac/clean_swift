//
//  Presenter, recebe dados do Interactor e retornad formato para o Viwcontroller
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


protocol LoginPresenterLogic
{
    //View controller de login
    var viewController : LoginViewControllerLogic? { get set }
    //Recebe dados de retorno do interactor
    func presenteLogin(response : Authentication.Login.Response)
    func presenteError(response : Authentication.Login.Response)
    func presenteValidateError(msg : String)
}

class LoginPresenter: NSObject, LoginPresenterLogic {

    var viewController : LoginViewControllerLogic?  

    /// retorno do interactor, é formatado e retornado ao viewcontroller
    ///
    /// - Parameter response:retorno do interactor.
    func presenteLogin(response : Authentication.Login.Response){
        var viewModel =  Authentication.Login.ViewModel(userId: String( response.userAccount?.userId ?? 0), name: response.userAccount?.name ?? "",
                                                        bankAccount:(response.userAccount?.bankAccount ?? "") + " / " + (response.userAccount?.agency ?? ""),agency: "" , balance: (response.userAccount?.balance.toLocalFormat())!)
        viewController?.loginSucess(viewModel)
    }
    /// Dispara erro para viewcontroller
    ///
    /// - Parameter response:retorno do interactor.
    func presenteError(response : Authentication.Login.Response){
        viewController?.showError(msg: response.error)
    }
    /// dispara erro geneŕico
    ///
    /// - Parameter msg: mensagem.
    func presenteValidateError(msg : String){
        viewController?.showError(msg: msg)
    }

    
}
