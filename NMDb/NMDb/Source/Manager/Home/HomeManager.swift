//
//  HomeManager.swift
//  NMDb
//
//  Created by Gian Nucci on 31/01/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import UIKit

class HomeManager: BaseManager {

    /// Movie Business
    private lazy var business: MovieBusiness = {
        return MovieBusiness()
    }()
    
    /// Upcoming Movies Operaion manager
    ///
    /// - Parameters:
    ///   - refresh: needs to refresh
    ///   - completion: completion callback
    func upcomingMovies(refresh: Bool = false,
                        _ completion: @escaping MovieListUICallback) {
        addOperation {
            self.business.upcomingMovies(refresh: refresh, { (discover) in
                OperationQueue.main.addOperation {
                    completion(discover)
                }
            })
        }
    }
    
    /// Popular Movies Operaton manager
    ///
    /// - Parameters:
    ///   - refresh: needs to refresh
    ///   - completion: completion callback
    func popularMovies(refresh: Bool = false,
                       _ completion: @escaping MovieListUICallback) {
        addOperation {
            self.business.popularMovies(refresh: refresh, { (discover) in
                OperationQueue.main.addOperation {
                    completion(discover)
                }
            })
        }
    }
}
