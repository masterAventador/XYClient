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
    static let urlString = "http://8.140.207.230:8080";
    static let url = URL(string: urlString)!
    
    public static func post<T:Message, U:Message>(_ request: T, responseType: U.Type, finish: @escaping (Result<U,AFError>) -> Void) {
        let reqSerializer = ProtobufRequestSerializer(message: request)
        let respSerializer = ProtobufResponseSerializer<U>()
        AF.request(reqSerializer).response(responseSerializer: respSerializer) { response in
            finish(response.result)
        }
    }
    
    
    struct ProtobufRequestSerializer<T:Message>: URLRequestConvertible {
        let message: T
        
        func asURLRequest() throws -> URLRequest {
            var request = URLRequest(url:url)
            request.setValue("application/x-protobuf", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = try? message.serializedData()
            return request
        }
    }
    
    struct ProtobufResponseSerializer<T:Message>: DataResponseSerializerProtocol {
        typealias SerializedObject = T
        
        func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: (any Error)?) throws -> SerializedObject {
            guard error == nil else { throw error! }
            guard let data else { throw AFError.responseValidationFailed(reason: .dataFileNil) }
            return try T(serializedData: data)
        }
    }
}
