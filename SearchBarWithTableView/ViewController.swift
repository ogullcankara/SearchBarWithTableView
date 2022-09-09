//
//  ViewController.swift
//  SearchBarWithTableView
//
//  Created by Ogulcan Kara on 8.09.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var countries:[String] = [String]()
    var searchResultCountries:[String] = [String]()
    var isSearch = false
    var searchTerms = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries = ["Türkiye", "Germany", "İtaly", "Ukraine", "France", "Egypt", "Chinese", "India", "Russia", "England", "Brazil", "Uruguay", "Argentina", "Ghana"]
        
        self.searchBar.delegate = self
        self.searchBar.scopeButtonTitles = ["First", "Second"]
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch {
            return searchResultCountries.count
        }else{
            return countries.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCell", for: indexPath)
        
        if isSearch {
            cell.textLabel?.text = searchResultCountries[indexPath.row]
        }else{
            cell.textLabel?.text = countries[indexPath.row]
        }
        
        return cell
        
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearch {
            print("Selected Country : \(searchResultCountries[indexPath.row])")
        }else{
            print("Selected Country : \(countries[indexPath.row])")
        }
        
        
    }
}

extension ViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Result : \(searchText)")
        
        if searchText == "" {
            isSearch = false
        }else {
            isSearch = true
            searchResultCountries = countries.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //print("Cancel Clicked")
        //searchBar.text = self.searchTerms
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0 {
            print("First Clicked")
        }
        
        if selectedScope == 1 {
            print("Second Clicked")
        }
    }
    
}
