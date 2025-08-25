//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by OSX on 10/07/2025.
//

import UIKit
import Combine

class MoviesListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    var viewModel: MoviesListViewModel!
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Popular Movies"
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell: MovieCollectionViewCell.self)
    }

    // MARK: - Bindings
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                isLoading ? self.showLoadingIndicator() : self.hideLoadingIndicator()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { error in
                self.errorLabel.text = error
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let movie = viewModel.movies[indexPath.row]
        cell.configure(data: movie)
        cell.favoriteButtonAction = { [weak self] in
            self?.viewModel.toggleFavorite(at: indexPath.row)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        viewModel.coordinator?.showMovieDetails(movieID: selectedMovie.id)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    private var collectionSpacing: CGFloat { 16 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let totalSpacing = (collectionSpacing * (columns - 1)) + (collectionSpacing * 2)
        let width = (collectionView.frame.width - totalSpacing) / columns
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: collectionSpacing, left: collectionSpacing, bottom: collectionSpacing, right: collectionSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        collectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionSpacing
    }
}

// MARK: - Loading Indicator
extension MoviesListViewController {
    
    private func showLoadingIndicator() {
        spinnerView = displaySpinner(onView: view)
    }
    
    private func hideLoadingIndicator() {
        if let spinner = spinnerView {
            removeSpinner(spinner: spinner)
        }
    }
}
