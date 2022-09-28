//
//  File.swift
//  
//
//  Created by Mario on 2022/9/14.
//

import Foundation
import Alamofire
import Promises

public typealias NetworkHeader = [String: String]

public protocol NetworkAPI {

    /// 网络请求
    var httpMethod: Alamofire.HTTPMethod { get }

    /// 超时
    var timeoutInterval: TimeInterval? { get }

    /// 请求头
    var headers: NetworkHeader? { get }

    /// 请求体
    var body: Data? { get }

    var parameters: [String: Any]? { get }

    /// baseURL
    var baseUrl: URL? { get }

    ///
    var path: String { get }
}


public class NetworkService {

    /// 创建URLRequest
    /// - Parameters:
    ///   - url: 链接地址
    ///   - body: 消息体
    ///   - method: 请求方式
    ///   - headers: 头
    /// - Returns: DataRequest
    public static func urlRequest(url: String, timeoutInterval: TimeInterval, body: Data?, method: String?, headers: NetworkHeader?) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.httpMethod = method
        request.timeoutInterval = timeoutInterval
        return request
    }

    public static func dataRequest(urlRequst: URLRequest) -> DataRequest? {
        return nil
    }
}


fileprivate class NetworkInterceptor: RequestAdapter, RequestRetrier {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {

    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

    }


}

