//
//  CreditsCollectionViewController.swift
//  NMDb
//
//  Created by Gian Nucci on 02/02/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CreditsCollectionViewController: UICollectionViewController, Identifiable {

    var movieId: Int?
    
    private var credits: Credits? {
        didSet {
            if credits != nil {
                collectionView?.reloadData()
            }
        }
    }
    
    private lazy var manager = {
        return DetailsManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCredits()
    }
    
    private func loadCredits() {
        guard let movieId = self.movieId else {
            return
        }
        
        manager.fetchCredits(identifier: movieId) { [weak self] (result) in
            guard let _self = self else { return }
            
            do {
                guard let credits = try result() else {
                    throw BusinessError.invalidValue
                }
                _self.credits = credits
            } catch {
                HandleError.handle(error: error)
            }
        }
    }
}

extension CreditsCollectionViewController {
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return credits?.castList?.count ?? 0
        default: return credits?.crewList?.count ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CreditsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if indexPath.section == 0 {
            if let cast = credits?.castList?[indexPath.row] {
                cell.setup(title: cast.name, subTitle: cast.character, image: cast.profilePath)
            }
        } else {
            if let crew = credits?.crewList?[indexPath.row] {
                cell.setup(title: crew.name, subTitle: crew.job, image: crew.profilePath)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        let cell: CreditsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.imageView.kf.cancelDownloadTask()
    }
}
