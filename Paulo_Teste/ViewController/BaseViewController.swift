//
//  Implementações de base para todos Viewcontrollers
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 09/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit
//Está com bug, desativado do código
//import JGProgressHUD

class BaseViewController: UIViewController {
   //i let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup das implementações do metodo atual
        SetupModule.shared.configure(self)

        // Do any additional setup after loading the view.
    }
    
 
    /// usado ao fazer loading de dados
    ///
    func showProgress(){
       // hud.textLabel.text = "Carregando"
       // hud.show(in: self.view)
    }
    /// remove hud da tela
    ///
    func hideProgress(){
      // hud.dismiss()
    }

    
    
}
