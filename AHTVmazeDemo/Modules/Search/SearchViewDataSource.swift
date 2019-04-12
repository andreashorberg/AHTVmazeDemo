//
//  SearchViewDataSource.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class SearchViewDataSource: NSObject, UICollectionViewDataSource {
    
    var tvShows = [TVShow]()
    var imageCache = NSCache<NSString, UIImage>()
    
    func performSearch(request: ShowSearchRequest, completion: @escaping (Result<Bool, NetworkingError>) -> ()) {
        let router = SearchRouter.showSearch(request: request)
        let provider = NetworkingProvider(router: router)
        provider.send() { result in
            switch result {
            case .success(let searchDictionary):
                let tvShows = searchDictionary
                    .compactMap({ $0["show"] as? [String: Any] ?? nil })
                    .compactMap({ TVShow.from($0) })
                self.tvShows = tvShows
                completion(.success(!tvShows.isEmpty))
            case .failure(let error):
                self.tvShows = []
                completion(.failure(error))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowCell", for: indexPath)
        guard let tvShowCell = cell as? TVShowCell else { return cell }
        configure(cell: tvShowCell, atIndexPath: indexPath)
        return tvShowCell
    }
    
    func configure(cell: TVShowCell, atIndexPath indexPath: IndexPath) {
        guard tvShows.indices.contains(indexPath.row) else { return }
        let tvShow = tvShows[indexPath.row]
        cell.title.text = tvShow.name
        guard let image = tvShow.image.mediumURL else {
            cell.imageLoading.isHidden = true
            return
        }
        downloadImage(image) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    cell.imageLoading.isHidden = true
                case .success(let image):
                    UIView.animate(withDuration: 0.5, animations: {
                        cell.imageLoading.alpha = 0
                        cell.image.image = image
                    })
                }
            }
        }
    }
    
    let imageQueue = DispatchQueue(label: "se.imaginareal.AHTVmazeDemo.imageDownloadThread",
                                   qos: .background,
                                   attributes: .concurrent,
                                   autoreleaseFrequency: .workItem,
                                   target: nil)
    
    private func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, NetworkingError>) -> ()) {
        let url = url.toHttps()
        
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
        } else {
            imageQueue.async {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        completion(.failure(.failedDownload))
                        return
                    }
                    guard let data = data, let image = UIImage(data: data) else {
                        completion(.failure(.failedDownload))
                        return
                    }
                    completion(.success(image))
                }).resume()
            }
        }
    }
}
