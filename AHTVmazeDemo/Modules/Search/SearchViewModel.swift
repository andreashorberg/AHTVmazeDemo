//
//  SearchViewModel.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-12.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

struct SearchViewModel {
    let dataSource = SearchViewDataSource()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        return layout
    }()
    
    var deviceState: DeviceState {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return UIApplication.shared.statusBarOrientation.isLandscape ? .phoneLandscape : .phonePortrait
        case .pad:
            return .tablet
        default:
            return .phonePortrait
        }
    }
    
    var scrollDirection: UICollectionView.ScrollDirection {
        switch deviceState {
        case .phonePortrait:
            return .vertical
        case .phoneLandscape:
            return .horizontal
        case .tablet:
            return .vertical
        }
    }
    
    var lastRequest: ShowSearchRequest?
    
    mutating func search(for keyword: String, completion: @escaping (Result<Bool, NetworkingError>) -> ()) {
        lastRequest = ShowSearchRequest(query: keyword)
        dataSource.performSearch(request: lastRequest!, completion: completion)
    }
}
