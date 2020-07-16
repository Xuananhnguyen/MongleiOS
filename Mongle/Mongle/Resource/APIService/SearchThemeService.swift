//
//  SearchThemeService.swift
//  Mongle
//
//  Created by Yunjae Kim on 2020/07/16.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct SearchThemeService {
    static let shared = SearchThemeService()
    
    private func makeParameter(_ words : String)-> Parameters{
        return ["words" : words]
    }
    
    
    func search(words : String, completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json" , "token": UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)!]
        let dataRequest = Alamofire.request(APIConstants.searchThemeURL,
                                            method: .get,
                                            parameters: makeParameter(words),
                                            encoding: URLEncoding.default,
                                            headers: header)
        
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success :
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let data = dataResponse.result.value else {return}
                let networkResult = self.judge(by: statusCode, data)
                completion(networkResult)
                
            case .failure :
                completion(.networkFail)
                
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
    private func judge(by statusCode : Int , _ data : Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200 :
            
            return searchThemes(by: data)
        case 400:
            return showErrorMessage(by : data)
        case 600 :
            return .serverErr
        default :
            return .networkFail
            
        }
        
    }
    
    private func searchThemes(by data : Data) -> NetworkResult<Any> {
      
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[SearchThemeData]>.self, from: data)
            else { return .pathErr }
        
        
        guard let data = decodedData.data else{
            return .requestErr(decodedData.message)
        }
        
        return .success(data)
        
    }
    
    private func showErrorMessage(by data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[SearchThemeData]>.self, from: data)
            else { return .pathErr }
        
        print(decodedData.message)
        return .requestErr(decodedData.message)
    }
    
    
    
    
    
    
    
}
