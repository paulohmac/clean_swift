//
//  Implementação da API que retorna os dados
//  Paulo_Teste
//
//  Created by Paulo Henrique Machtura on 05/08/20.
//  Copyright © 2020 Paulo Henrique Machtura. All rights reserved.
//

import UIKit
 
// MARK: Interface
protocol AuthenticationProtocol
{
    //login na api
    func login(request: Authentication.Login.Request,_  completionHandler:  @escaping (Result<Any>) -> Void)
    
    //retorna registros bancários
    func listStatements(request: ListStatement.List.Request,_  completionHandler:  @escaping (Result<Any>) -> Void)

}



class AutenticationAPI: AuthenticationProtocol {
    /// faz requisição de login usando NSURLSession da Apple
    ///
    /// - Parameter request: dados de login.
    /// - Parameter completionHandler: chamada assyncrona com dados de retorno.
    func login(request: Authentication.Login.Request,  _ completionHandler:  @escaping (Result<Any>) -> Void) {
        let strUrl = String(Config.endpoint)
        let paramString = String(format:"user=%@&password=%@", request.user ,request.password)
        do {
            
            let requestURL: URL = URL(string: strUrl)!
            var urlRequest = URLRequest(url:requestURL)
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
            urlRequest.httpBody = paramString.data(using: .utf8)
            
            urlRequest.httpMethod  = "POST"
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
            
            
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) -> Void in
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                print (String(data: data!, encoding: String.Encoding.utf8))
                
                if (statusCode == 200) {
                    do{
                        if error != nil {
                            print(error)
                            return completionHandler( Result.Failure(error!))
                        }
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let ret : Login  = try! decoder.decode(Login.self, from: data!)
                        return completionHandler( Result.Success( ret ))
                    }catch {
                        return completionHandler( Result.Failure(error))
                    }
                }else{
                    let errorRet = NSError(domain:"Erro HTTP: \(statusCode)", code:httpResponse.statusCode, userInfo:nil)
                    return completionHandler( Result.Failure(errorRet))
                }
            })
            
            task.resume()
        } catch {
            return completionHandler( Result.Failure(error))
        }
    }
    /// Lsita registros do usuário pássado no parametro request
    ///
    /// - Parameter request: dados do usuário.
    /// - Parameter completionHandler: dados de retorno.
    func listStatements(request: ListStatement.List.Request,  _ completionHandler:  @escaping (Result<Any>) -> Void) {
        var strUrl = String(Config.statements)
        strUrl = String(format:strUrl, request.userId)
        do {
            
            let requestURL: URL = URL(string: strUrl)!
            var urlRequest = URLRequest(url:requestURL)
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//            urlRequest.httpBody = paramString.data(using: .utf8)
            
            urlRequest.httpMethod  = "GET"
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
            
            
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) -> Void in
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                print (String(data: data!, encoding: String.Encoding.utf8))
                
                if (statusCode == 200) {
                    do{
                        if error != nil {
                            print(error)
                            return completionHandler( Result.Failure(error!))
                        }
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let ret : StatementList  = try! decoder.decode(StatementList.self, from: data!)
                        return completionHandler( Result.Success( ret ))
                    }catch {
                        return completionHandler( Result.Failure(error))
                    }
                }else{
                    let errorRet = NSError(domain:"Erro HTTP: \(statusCode)", code:httpResponse.statusCode, userInfo:nil)
                    return completionHandler( Result.Failure(errorRet))
                }
            })
            
            task.resume()
        } catch {
            return completionHandler( Result.Failure(error))
        }
    }
    
    
}


