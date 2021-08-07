//
//  Classe para teste do Interactor Main
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 14/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

class MainPresenterSpy: MainPresenterLogic {
    var viewController : MainViewController?
    var completionHandler : ((Bool)->Void)?
    
    func presenteList(response : ListStatement.List.Response){
        var stateMentList = [ListStatement.List.ViewModelStatement]()
        response.statementList?.forEach({ item in
            stateMentList.append(ListStatement.List.ViewModelStatement(title: item.title, desc: item.desc, date: item.date.toStrigDate(), value: item.value.toLocalFormat()))
        })

        if stateMentList.count > 0 {
            self.completionHandler!(true)
        }
    }
    
    func presenteError(response : ListStatement.List.Request){
    }
    
}
