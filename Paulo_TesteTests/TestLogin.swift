//
//  Teste para módulo login
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
    
    override func setUpWithError() throws {
        loginWorker = LoginWorker(auth: AutenticationAPI())
        request = Authentication.Login.Request( user: "test_user", password: "Test@1" )
        auth = AutenticationAPI()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginWorker()throws{
        loginWorker!.login(request: request!, { result -> Void in
            if let data = result.userAccount {
                XCTAssertNotNil(data,  "resposta não vazia")
                XCTAssert(data.name=="Jose da Silva Teste","usuário correto")
            }
        })
    }

    func testLoginNetWork()throws{
        auth!.login(request: request! , { result  in
            if let remoteData = result.associatedValue() as? Login {
                XCTAssertNotNil( remoteData,  "resposta não vazia")
                XCTAssert( remoteData.userAccount?.name == "Jose da Silva Teste","usuário correto")
            }
        })
        
    }

    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
