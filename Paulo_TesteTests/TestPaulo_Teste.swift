//
//  Testes
//
//  Created by Paulo Henrique Machtura on 13/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//
import XCTest
import Paulo_Teste

class TestPaulo_Teste: XCTestCase {
    var loginWorker : LoginWorker?
    var request  : Authentication.Login.Request?
    var auth: AuthenticationProtocol?

    var loginInteractor: LoginInteractor?
    var loginPresenter: LoginPresenterSpy?
    var loginData : Login?

    var mainInteractor: MainInteractor?
    var mainPresenter: MainPresenterSpy?

    
    
    var user = "test_user"
    var password = "Test@1"
    

    override func setUpWithError() throws {
        loginWorker = LoginWorker(auth: AutenticationAPI())
        request = Authentication.Login.Request( user: user, password: password )
        auth = AutenticationAPI()
        loginInteractor = LoginInteractor()
        loginPresenter = LoginPresenterSpy()
        loginInteractor!.presenter = loginPresenter
    }

    override func tearDownWithError() throws {
    }
    //LoginWorker sendo testado
    func testLoginWorker()throws{
        let expectation = self.expectation(description: "Login Worker expectation")
        loginWorker!.login(request: request!, { result -> Void in
            if let data = result.userAccount {
                XCTAssertNotNil(data,  "resposta não vazia")
                XCTAssert(data.name=="Jose da Silva Teste","usuário correto")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)

    }
    //Testa o login
    func testLoginNetWork()throws{
        let expectation = self.expectation(description: "Login network expectation")
        auth!.login(request: request! , { result  in
            if let remoteData = result.associatedValue() as? Login {
                self.loginData = remoteData
                XCTAssertNotNil( remoteData,  "resposta não vazia")
                XCTAssert( remoteData.userAccount?.name == "Jose da Silva Teste","usuário correto")
                expectation.fulfill()

            }
        })
        waitForExpectations(timeout: 1, handler: nil)

    }
    //Testa lista de registros
    func testListStatementsNetWork()throws{
        let expectation = self.expectation(description: "List statement expectation")
        let request = ListStatement.List.Request(userId: "1")
        auth!.listStatements(request: request , { result  in
            if let remoteData = result.associatedValue() as? StatementList {
                XCTAssertNotNil(  remoteData,  "lista statements resposta não vazia")
                XCTAssert( remoteData.statementList.count == 9,"registros da conta corretos")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)

    }
    
    //MainWorker sendo testado
    func testMainWorkerNetWork()throws{
        let request = ListStatement.List.Request(userId: String(self.loginData?.userAccount?.userId ?? 0))
        let expectation = self.expectation(description: "TestNet expectation")

        auth!.listStatements(request: request , { result  in
            if let remoteData = result.associatedValue() as? StatementList {
                XCTAssertNotNil(  remoteData,  "lista statements resposta não vazia")
                XCTAssert( remoteData.statementList.count == 9,"registros da conta corretos")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 1, handler: nil)

    }

    //Testa o interactor do login
    func testLoginInteractor()throws{
        let request = Authentication.Login.Request( user: user, password: password)
        loginInteractor?.login(request: request)
        let expectation = self.expectation(description: "Login interactor")
        loginPresenter?.completionHandler = { ret in
            XCTAssertTrue( ret, "teste Logininteractor")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }


    //Testa o interactor principal
    func testMainInteractor()throws{
        let expectation = self.expectation(description: "Main interactor")
        let request = ListStatement.List.Request(userId: "1" )
        mainInteractor?.loadData(request: request)
        mainPresenter?.completionHandler = { ret in
            XCTAssertTrue( ret, "teste MainInteractor")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    
    
}
