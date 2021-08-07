//
//  View controller principal
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 02/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit

// MARK: Interface

protocol MainViewControllerLogic
{
    var loginViewModel : Authentication.Login.ViewModel? {set get}
    var viewModel : ListStatement.List.ViewModel? {set get}
    var interactor : MainInteractor? {set get}
    var router: MainRouterLogic? {set get}

    func presenteData(response : ListStatement.List.ViewModel)
}

// MARK: Implementação

class MainViewController: BaseViewController, MainViewControllerLogic {
    
    // MARK: Ui Controls
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var statementTableView: UITableView!
    
    // MARK: Variáveis
    var loginViewModel : Authentication.Login.ViewModel?
    var viewModel : ListStatement.List.ViewModel?
    var interactor : MainInteractor?
    var router: MainRouterLogic?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        UIView.animate(withDuration: 0.7, delay: 1.0, options:  [.transitionFlipFromRight], animations: {
          self.view.layoutIfNeeded()
        }, completion: nil)
    }
    /// Carrega os dados baseado no usuário vindo do login
    ///
    func loadData(){
        showProgress()
        let request = ListStatement.List.Request(userId: loginViewModel?.userId ?? "")
        interactor?.loadData(request: request)
    }
    
    /// Apresenta os dados
    /// - Parameter response: retorno do presente.
    func presenteData(response : ListStatement.List.ViewModel){
        self.setupMainData()
        self.viewModel = response
        statementTableView.reloadData()
        hideProgress()

    }
    // MARK: setup dos dados
    func setupMainData(){
        nameLbl.text =  loginViewModel?.name
        accountLbl.text =  loginViewModel?.bankAccount
        balanceLbl.text =  loginViewModel?.balance
    }
    
    // MARK: Eventos
    @IBAction func logotTap(_ sender: Any) {
        router?.logoutApp(current: self)
    }
    
    
}

// MARK: Delegates da tableview
extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }
    
}


extension MainViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    /// Baseado nos dados que estão no viewModel, popula a tableview.
    ///
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell;
        
        cell = (self.statementTableView.dequeueReusableCell(withIdentifier: "statementCell") as! UITableViewCell?)!
        
        if let viewWithTag = cell.viewWithTag(5656) {
            viewWithTag.removeFromSuperview()
        }
        
        if let labelLbl = cell.viewWithTag(1) as? UILabel {
            labelLbl.text = self.viewModel?.statementList[indexPath.section].title
        }
        
        if let labelLbl = cell.viewWithTag(2) as? UILabel {
            labelLbl.text = self.viewModel?.statementList[indexPath.section].date
        }
        
        if let labelLbl = cell.viewWithTag(3) as? UILabel {
            labelLbl.text = self.viewModel?.statementList[indexPath.section].desc
        }
        
        if let labelLbl = cell.viewWithTag(4) as? UILabel {
            labelLbl.text = self.viewModel?.statementList[indexPath.section].value
            
        }
        //Sombreado e bordas a celula
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        let borderColor: UIColor = UIColor.init(hexString: "#DBDFE3")
        cell.layer.borderColor = borderColor.cgColor
        
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 1

        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let model = self.viewModel {
            return model.statementList.count
        }else{
            return 0
        }
    }
    
    
}
