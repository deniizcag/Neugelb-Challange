//
//  MovieListVC.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 24.06.2022.
//

import UIKit
import MBProgressHUD
import Kingfisher
class MovieListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: MovieListVMProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    var movieList: [Movie] = []
    var favMovies: [Movie] = []
    var watchedMovies: [Movie] = []
    var toWatchMovies: [Movie] = []
    var sections = ["Favorites", "Watched", "To Watch"]
    var selectedMovie: Movie?
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.isEnabled = false
        return button
    }()
    
    var smallPadding: CGFloat = 20
    var bigPadding: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNextButton()
        configureTableView()
        viewModel?.fetchAllMovies()
        viewModel?.fetchFavoriteMovies(movies: viewModel?.fetchedMovies)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.selectMovie(movie: nil)
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.register(MovieSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesCell")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.sectionHeaderHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -smallPadding)
        ])
    }
    
    func configureNextButton() {
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: bigPadding),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -bigPadding),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -smallPadding),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func showProgressHUD() {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = "Fetching Movies"
        Indicator.isUserInteractionEnabled = false
        Indicator.show(animated: true)
    }
    
    func dismissProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    @objc func nextButtonTapped() {
        viewModel?.navigateToDetailScreen(for: viewModel?.selectedMovie)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as! FavoritesTableViewCell
            cell.favoriteMovies = self.favMovies
            cell.selectedMovie = selectedMovie
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath as IndexPath) as! MovieTableViewCell
            let movie = watchedMovies[indexPath.row]
            cell.setUI(for: movie, isSelected: selectedMovie == movie)
            cell.movieImage.kf.setImage(with: URL(string: watchedMovies[indexPath.row].imageURL))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath as IndexPath) as! MovieTableViewCell
            cell.movieImage.kf.setImage(with: URL(string: toWatchMovies[indexPath.row].imageURL))
            let movie = toWatchMovies[indexPath.row]
            cell.setUI(for: movie, isSelected: selectedMovie == movie)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MovieSectionHeaderView
        view.headerLabel.text = sections[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.watchedMovies.count
        case 2:
            return self.toWatchMovies.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedMovie = favMovies[indexPath.row]
        case 1:
            selectedMovie = watchedMovies[indexPath.row]
        case 2:
            selectedMovie = toWatchMovies[indexPath.row]
        default:
            break
        }
        viewModel?.selectMovie(movie: selectedMovie!)
    }
    
    func updateButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ?.blue : .gray
    }
}

extension MovieListVC: MovieListVMDelegate, FavoritesTableViewCellDelegate {
    
    func handleViewModelOutputs(_ output: MovieListVMOutput) {
        switch output {
        case .setLoading(let isLoading):
            isLoading ? showProgressHUD() : dismissProgressHUD()
        case .showMovieList(let fetchedMovies):
            if let fetchedMovies = fetchedMovies {
                self.movieList = fetchedMovies
            }
        case .showFavoriteMovies(let favorites):
            self.favMovies = favorites
        case .showWatchedMovies(let wathedMovies):
            self.watchedMovies = wathedMovies
        case .showToWatchMovies(let toWatchMovies):
            self.toWatchMovies = toWatchMovies
        case .updateButton(let isSelected):
            updateButton(isEnabled: isSelected)
        case .showSelectedMovie(let movie):
            navigateToDetailScreen(for: movie)
        case .updateSelectedCellBorder(let movie):
            self.selectedMovie = movie
        case .error(_):
            let alert = UIAlertController(title: "Oops!", message: "Something went wrong!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.tableView.reloadData()
    }
    
    func navigateToDetailScreen(for movie: Movie?) {
        let viewController = MovieDetailBuilder.make(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func favoritesTableViewCellDelegateMovieSelected(movie: Movie) {
        viewModel?.selectMovie(movie: movie)
    }
}

