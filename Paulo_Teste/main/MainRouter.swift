//  Faz roteamento do viewcontroller principal
//  MainRouter.swift
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

// MARK: interface
protocol MainRouterLogic
{
    func logoutApp(current : UIViewController)
}

// MARK: Implementação
class MainRouter: NSObject, MainRouterLogic {
    
    ///   Fecha o view controller atual retornando ao main
    /// - Parameter current: view controller principal.
    func logoutApp(current : UIViewController){
        current.dismiss(animated: true, completion: nil)
    }
       

}
