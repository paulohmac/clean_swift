//
//  MainPresenter.swift
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 04/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit


// MARK: Protocolo

protocol MainPresenterLogic
{
    //View controller principal
    var viewController : MainViewController? { get set }
    //Faz chamada na view controller exibindo os dados
    func presenteList(response : ListStatement.List.Response)
    //Exibe dados de erro
    func presenteError(response : ListStatement.List.Request)
}
 
// MARK: Implementação
class MainPresenter:  MainPresenterLogic {
        
    var viewController : MainViewController?
    
    func presenteList(response : ListStatement.List.Response){
        var stateMentList = [ListStatement.List.ViewModelStatement]()
        //Alimenta lista com o retorno da API
        response.statementList?.forEach({ item in
            stateMentList.append(ListStatement.List.ViewModelStatement(title: item.title, desc: item.desc, date: item.date.toStrigDate(), value: item.value.toLocalFormat()))
        })

        let viewModel = ListStatement.List.ViewModel(statementList: stateMentList)
        viewController?.presenteData(response: viewModel)
    }
    
    func presenteError(response : ListStatement.List.Request){
    }
    
}
