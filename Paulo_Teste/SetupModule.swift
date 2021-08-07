//
//  SetupModule.swift
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 06/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

class SetupModule: NSObject {
    static let shared = SetupModule()
    
    private override init() {}
    
    func configure(_ viewController: UIViewController) {
        if let loginViewController =  viewController as? LoginViewController {
            let interactor = LoginInteractor()
            let presenter = LoginPresenter()
            let router = LoginRouter()
            loginViewController.interactor = interactor
            loginViewController.router = router
            interactor.presenter = presenter as! LoginPresenterLogic
            presenter.viewController = loginViewController
            router.loginViewController = loginViewController
        }

        if let mainViewController =  viewController as? MainViewController {
            let interactor = MainInteractor()
            let presenter = MainPresenter()
            let router = MainRouter()
            mainViewController.interactor = interactor
            mainViewController.router = router
            interactor.presenter = presenter as! MainPresenterLogic
            presenter.viewController = mainViewController
        }

        /*        if let mainViewController as! LoginVieontroller{
            let interactor = LoginInteractor()
            let presenter = LoginPresenter()
            let router = LoginRouter()
            mainViewController.interactor = interactor
            mainViewController.router = router
            interactor.presenter = presenter as! LoginPresenterLogic
            presenter.viewController = mainViewController
            router.loginViewController = mainViewController()
        }*/
    }
}
