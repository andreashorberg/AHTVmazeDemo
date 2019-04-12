//
//  ViewController.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = viewModel.dataSource
        collectionView.collectionViewLayout = viewModel.layout
        collectionView.delegate = self
        setupSearchBar()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        viewModel.search(for: keyword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let shouldRefresh):
                if shouldRefresh {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(_):
                
                #warning("Show error")
            }
        }
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        searchField?.textColor = .white
        
        let placeholderLabel = searchField?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.textColor = .white
        
        let glassIconView = searchField?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        switch viewModel.deviceState {
        case .phonePortrait:
            return CGSize(width: width, height: width)
        case .phoneLandscape:
            return CGSize(width: height, height: height)
        case .tablet:
            let columns: CGFloat = 4
            let padding: CGFloat = (16 * (columns - 1) / columns)
            
            return CGSize(width: (width / columns) - padding, height: (width / columns) - padding)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.viewModel.layout.scrollDirection = self.viewModel.scrollDirection
            self.viewModel.layout.invalidateLayout()
            self.view.layoutIfNeeded()
        })
    }
}

enum DeviceState {
    case phonePortrait
    case phoneLandscape
    case tablet
}
