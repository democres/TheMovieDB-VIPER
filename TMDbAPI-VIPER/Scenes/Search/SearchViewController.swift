//
//  SearchViewController.swift
//  IMDbAPI-VIPER
//
//  Created by David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit
import AlamofireImage

final class SearchViewController: UIViewController, SeachViewProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var filterView: RoundedView!
    @IBOutlet weak var typePickButton: UIButton!
    @IBOutlet weak var yearPickButton: UIButton!
    
    @IBOutlet weak var pickerContentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var types: [String] = []
    private var years: [String] = []
    
    private var isFilterViewShowing: Bool = false
    private var currentPickerViewType: PickerViewType = .type
    
    private var selectedType: String = ""
    private var selectedYear: String = ""
    
    var mediaArray: [Media]?
    
    private var isValidName: Bool = false {
        didSet {
            handleNameField()
        }
    }
    
    var presenter: SearchPresenterProtocol!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Handle Presenter Output
    
    func handleOutput(_ output: SearchPresenterOutput) {
        switch output {
        case .allMovies(let movies):
            self.mediaArray = movies
            self.collectionView.reloadData()
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .getMediaList(let searchResults):
            self.presenter.showMediaList(medias: searchResults)
        case .showYears(let years):
            self.years = years
        case .showTypes(let types):
            self.types = types
        case .isValidName(let isValid):
            self.isValidName = isValid
        }
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        hideFilterView()
        hidePickerView()
        presenter.getYearDatas()
        presenter.getTypeDatas()
        
        presenter.loadMovies()
        
        
       //MOVIE GRID LAYOUT
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3.3
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        //GET GRID MOVIE DATA
        getMoviesGridData()
        
    }
    
    private func getMoviesGridData(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.collectionView.reloadData()
                
                //                print(self.movies)
                print(dataDictionary)
            }
        }
        task.resume()
    }
    
    private func showFilterView() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.filterView.transform = .identity
        },
                       completion: nil)
    }
    
    private func hideFilterView() {
        UIView.animate(withDuration: 0.5) {
            self.filterView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showPickerView() {
        self.pickerContentView.transform = .identity
        pickerView.reloadAllComponents()
    }
    
    private func hidePickerView() {
        self.pickerContentView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
    }
    
    private func handleNameField() {
        if !isValidName {
            showAlert(title: "Error", message: "The name field cannot be blank.")
        } else {
            presenter.load(title: searchTextField.text ?? "", type: selectedType, year: selectedYear)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        isFilterViewShowing = false
        hideFilterView()
        searchTextField.resignFirstResponder()
        
        presenter.validateNameField(name: searchTextField.text)
    }
    
    @IBAction func filtersButtonTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        
        isFilterViewShowing = !isFilterViewShowing
        
        if isFilterViewShowing {
            showFilterView()
        } else {
            hideFilterView()
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            currentPickerViewType = .type
        case 1:
            currentPickerViewType = .year
        default: break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.showPickerView()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            typePickButton.setTitle("Pick...", for: .normal)
        case 1:
            yearPickButton.setTitle("Pick...", for: .normal)
        default: break
        }
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        hideFilterView()
        isFilterViewShowing = false
        
        if let typeText = typePickButton.titleLabel?.text {
            if typeText != "Pick..." {
                selectedType = typeText
            } else {
                selectedType = ""
            }
        }
        
        if let yearText = yearPickButton.titleLabel?.text {
            if yearText != "Pick..." {
                selectedYear = yearText
            } else {
                selectedYear = ""
            }
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.hidePickerView()
        }
        
        let index = pickerView.selectedRow(inComponent: 0)
        switch currentPickerViewType {
        case .type:
            let title = types[index]
            typePickButton.setTitle(title, for: .normal)
        case .year:
            let title = years[index]
            yearPickButton.setTitle(title, for: .normal)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideFilterView()
        isFilterViewShowing = false
    }
}

// MARK: - UIPickerViewDataSource

extension SearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentPickerViewType {
        case .type:
            return types.count
        case .year:
            return years.count
        }
    }
}

// MARK: - UIPickerViewDelegate

extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentPickerViewType {
        case .type:
            return types[row]
        case .year:
            return years[row]
        }
    }
}

enum PickerViewType {
    case type
    case year
}





extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mediaArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = self.mediaArray?[indexPath.item]
        
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500/" + (movie?.poster ?? ""))

        cell.posterImageView?.af_setImage(withURL: baseUrl!)
        
        return cell
    }
    
}
    

