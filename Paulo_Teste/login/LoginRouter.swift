//
//  LoginRouter.swift
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

protocol LoginRouterLogic
{
    func routeToMain( viewModel: Authentication.Login.ViewModel )
}

class LoginRouter: NSObject, LoginRouterLogic
{
    weak var loginViewController : UIViewController?
    // MARK: Routing
    
    func routeToMain( viewModel: Authentication.Login.ViewModel )
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! MainViewController
        mainController.loginViewModel = viewModel
        loginViewController?.present(mainController, animated: true, completion: nil)
    }
    
    
}
