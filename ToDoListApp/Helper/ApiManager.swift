//
//  ApiManager.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 16/06/24.
//


import Foundation
import Alamofire
import RealmSwift

class ApiManager{
    
    static let shared = ApiManager()
    
    typealias loginHandler = (Result<LoginModel, ErrorCondition>) -> Void
    typealias apiHandler = (Result<UserListModel, ErrorCondition>)-> Void
    typealias addUserHandler = (Result<CreateUserModel,ErrorCondition>)-> Void
    typealias updateHandler = (Result<Any, ErrorCondition>)-> Void
    typealias deleteHandler = (Result<Any,ErrorCondition>)-> Void
    
    
    
    
    //MARK: Login API
    func loginApi(email:String,password:String,completion:@escaping loginHandler){
        guard let url = URL(string: "https://dummyjson.com/auth/login") else{
            completion(.failure(ErrorCondition.invalidUrl))
            return
        }
        let accessToken = "BearereySllEaTRmSnhsNlRibkY5S2NSa0FqTkwyWE84UC9ObE1iam9nbi9BM1BCdz0="
        let params = [
            "username": email,
            "password": password,
            "expiresInMins": 30,
        ]  as [String:Any]
        
        let hearders:HTTPHeaders = ["Authorization" : "Bearer "+accessToken,
                                    "Content-Type": "application/json"
        ]
        
        AF.request(url,method: .post, parameters: params,encoding: JSONEncoding.default, headers: hearders).response { response in
            switch response.result{
            case.success(let result):
                
                guard let data = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let postModel = try decoder.decode(LoginModel.self, from: data)
                    completion(.success(postModel))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case.failure(let error):
                completion(.failure(ErrorCondition.networkError(error)))
            }
        }
    }
    
    
    
    
    
    //MARK: Get List Api
    func getCategoriesApi(competion: @escaping apiHandler){
        guard let url = URL(string: "https://dummyjson.com/todos") else{
            competion(.failure(.invalidUrl))
            return
        }
        AF.request(url, method: .get, encoding: JSONEncoding.default).response { response in
            switch response.result{
            case.success(let categoriesList):
                guard let categoriesList = categoriesList else{
                    return
                }
                do{
                  let decoder = JSONDecoder()
                    let jsondata = try decoder.decode(UserListModel.self, from: categoriesList)
                    competion(.success(jsondata))
                }catch{
                    competion(.failure(.decodingError))
                }
                
            case.failure(let error):
                competion(.failure(.networkError(error)))
            }
        }
        
    }

   
    
    //MARK: Add Itmes API
    func CreateUserApi(todoTitle:String,userId:Int,completion:@escaping addUserHandler){
        guard let url = URL(string: "https://dummyjson.com/todos/add") else{
            completion(.failure(ErrorCondition.invalidUrl))
            return
        }

        let params = [
            "todo": todoTitle,
            "completed": true,
            "userId": userId,
        ]  as [String:Any]
        print("params",params)
        
        let hearders:HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url,method: .post, parameters: params,encoding: JSONEncoding.default, headers: hearders).response { response in
            switch response.result{
            case.success(let result):
                
                guard let data = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let postModel = try decoder.decode(CreateUserModel.self, from: data)
                    
//                    let json = String(data: data, encoding: .utf8)
//                    print(json)
                    completion(.success(postModel))
                } catch {
                    completion(.failure(.decodingError))
                }
                catch{
                    completion(.failure(ErrorCondition.decodingError))
                }
                
            case.failure(let error):
                completion(.failure(ErrorCondition.networkError(error)))
            }
        }
    }
    
    
    
    //MARK: Update Items API
    func updateApi(completed: Bool = false, id: Int, completion: @escaping updateHandler) {
        guard let url = URL(string: "https://dummyjson.com/todos/\(id)") else {
            completion(.failure(.invalidUrl))
            return
        }

        let params: [String: Any] = ["completed": completed]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let result):
                guard let data = result else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let json = String(data: data, encoding: .utf8)
                    print(json ?? "No JSON response")
                    completion(.success(json))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    //MARK: Delete Items API
    func deleteUser(id:Int, completion:@escaping deleteHandler){
        guard let url = URL(string: "https://dummyjson.com/todos/\(id)") else{
            completion(.failure(ErrorCondition.invalidUrl))
            return
        }
        AF.request(url,method: .delete, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case.success(let data):
                guard let data else {
                    completion(.failure(ErrorCondition.invalidResponse))
                    return
                }
                
                do{
                    
                    let json = String(data: data, encoding: .utf8)
                    print(json as Any)
                    completion(.success(json as Any))
                }
                catch{
                    completion(.failure(ErrorCondition.decodingError))
                }

                
                
            case.failure(let error):
                completion(.failure(ErrorCondition.networkError(error)))
            }
        }

    }
    
}



enum ErrorCondition: Error{
    
    case invalidUrl
    case invalidResponse
    case decodingError
    case networkError(Error?)
    
}




