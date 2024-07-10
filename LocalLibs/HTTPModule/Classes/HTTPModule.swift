//
//  HTTPModule.swift
//  Pods-XYClient
//
//  Created by Aventador on 2024/6/6.
//

import Foundation
import SwiftProtobuf
import Alamofire

public struct Http {
    static let urlString = "http://127.0.0.1:8080"
//    static let urlString = "http://8.140.207.230:8080"
    
    static let url = URL(string: urlString)!
    
    
    
    public static func post<T:Message, U:Message>(_ cmd: PHM_cmd, payload: T, responseType: U.Type, finish: @escaping (Result<U,AFError>) -> Void) {
        let reqSerializer = ProtobufRequestSerializer(message: payload, cmd: cmd)
        let respSerializer = ProtobufResponseSerializer<U>()
        AF.request(reqSerializer).response(responseSerializer: respSerializer) { response in
            finish(response.result)
        }
    }
    
    
    struct ProtobufRequestSerializer<T:Message>: URLRequestConvertible {
        let message: T
        let cmd: PHM_cmd
        
        func asURLRequest() throws -> URLRequest {
            var request = URLRequest(url:url)
            request.setValue("application/x-protobuf", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.post.rawValue
            
            var transport = PHM_request.with{
                $0.cmd = cmd
                if let payload = try? Google_Protobuf_Any(message: message) {
                    $0.payload = payload
                }
            }
            request.httpBody = try? transport.serializedData()
            return request
        }
    }
    
    struct ProtobufResponseSerializer<T:Message>: DataResponseSerializerProtocol {
        typealias SerializedObject = T
        
        func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: (any Error)?) throws -> SerializedObject {
            guard error == nil else { throw error! }
            guard let data else { throw AFError.responseValidationFailed(reason: .dataFileNil) }
            var transport = try PHM_response(serializedData: data)
            
            return try T(unpackingAny: transport.payload)
        }
    }
}

public struct XYHttpError: Error,CustomStringConvertible {
    
    let code:Int
    let msg:String
    
    public var description: String {
        "code:\(code),msg:\(msg)"
    }
}

