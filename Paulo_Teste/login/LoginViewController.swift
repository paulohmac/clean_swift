//
//  View controller para a tela inicial de login
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 02/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit
// MARK: - Interface
protocol LoginViewControllerLogic
{
    //Model transporte de dados
    var viewModel : Authentication.Login.ViewModel? {set get}
    //Interactor do modulo
    var interactor : LoginInteractor? {set get}
    //Define o roteamento da viewcontroller
    var router: LoginRouterLogic? {set get}
    //Retorno do metodo de login em caso de sucesso
    func loginSucess(_ view: Authentication.Login.ViewModel)
    //Retorno do metodo de login em caso de erro
    func showError(msg: String)
}

class LoginViewController: BaseViewController, LoginViewControllerLogic {
    // MARK: - Ui controls

    @IBOutlet weak var loginUserTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!

    // MARK: - Variaves
    var viewModel : Authentication.Login.ViewModel?
    var interactor : LoginInteractor?
    var router: LoginRouterLogic?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.7, delay: 1.0, options:  [.transitionFlipFromRight], animations: {
          self.view.layoutIfNeeded()
          self.setupIU()
        }, completion: nil)
    }
    // MARK: - Evento taps
    @IBAction func loginTap(_ sender: Any) {
        showProgress()
        //Envia requisição de login
        let request = Authentication.Login.Request( user: loginUserTxt.text ?? "", password: passwordTxt.text ?? "" )
        interactor?.login(request: request)
    }
    
    // MARK: - Implementação da interface
    func loginSucess(_ viewModel: Authentication.Login.ViewModel){
        hideProgress()
        router?.routeToMain(viewModel: viewModel)
    }
    
    func showError(msg: String){
        hideProgress()
        let alert = UIAlertController(title: "Erro", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   // MARK: - Setup UI
    private func setupIU(){
        loginBtn.layer.cornerRadius = 3
    }
    
 
}
