//
//  AppMoyaProvider.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import Foundation
import Alamofire
import Moya
import RxSwift
import RxMoya

class AppAlamofireManager: Session {
    
    static let sharedManager: AppAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 40 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 40 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return AppAlamofireManager(configuration: configuration, startRequestsImmediately: false)
    }()
}

final class AppMoyaProvider<Target> where Target: Moya.TargetType {
    private let provider: MoyaProvider<Target>
    private let networkManager = NetworkReachabilityManager(host: "www.apple.com")
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         session: Session = AppAlamofireManager.sharedManager,
         plugins: [PluginType] = [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    func request(_ target: Target) -> Single<Moya.Response> {
        if networkManager?.isReachable == false {
            return Single.error(AppError.networkError)
        }
        
        let request = provider.rx.request(target)
        return request.flatMap { response in
            // Here we could catch some unsuccessful status e.g 401 access token expired
            return Single.just(response)
        }.filterSuccessfulStatusCodes()
    }
}
