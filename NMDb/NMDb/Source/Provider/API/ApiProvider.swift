//
//  ApiProvider.swift
//  NMDb
//
//  Created by Gian Nucci on 30/01/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import Foundation

struct ApiProvider {
    
    // MARK: - Properties
    
    /// API version
    static let apiVersion = "3"
    
    /// Auth header Key
    static let apiSecret = "1f54bd990f1cdfb230adb312546d765d"
    
    /// Shared Networking Provider used to access API Services
    static var sharedProvider: NetworkProvider {
        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        guard let baseURL = URL(string: ApiProvider.baseUrl) else { fatalError("Base URL should not be empty") }
        
        return NetworkProvider(session: urlSession, baseURL: baseURL)
    }
    
    /// API Base URL
    ///
    /// - Returns: return baseURL
    private static var baseUrl: String {
        return "https://api.themoviedb.org/" + apiVersion
    }
    
    static var imageBaseUrl: String {
        return "https://image.tmdb.org/t/p/w500"
    }
}
