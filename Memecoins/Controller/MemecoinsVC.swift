//
//  MemecoinsVC.swift
//  Memecoins
//
//  Created by Alex Paul on 5/23/21.
//

import UIKit

class MemecoinsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var memecoins : [Memecoins] = []
    var filteredMemecoins : [Memecoins] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool{return searchController.searchBar.text?.isEmpty ?? true}
    var isFiltering : Bool{return searchController.isActive && !isSearchBarEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMemecoins()
        configureTableView()
        configureSearch()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func configureSearch(){
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Memecoins"
        navigationItem.searchController = searchController
    }
    
    func getMemecoins(){
        NetworkManger.shared.get(.tokens, urlString: "") { [weak self] (result: Result<[String:Any]?, ErroMessage> ) in
            guard let self = self else { return }
            switch result{
            case .success(let memecoins):
                if let memecoins = memecoins{
                    if let arrData = memecoins["data"] as? [String:Any]{
                        for items in arrData{
                            if let value = items.value as? [String:Any]{
                                let obj = Memecoins(withDicitonary: value)
                                self.memecoins.append(obj)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
}

extension MemecoinsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filteredMemecoins.count
        }
        return memecoins.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let save = UIContextualAction(style: .normal, title: "Save") { (_, _, completionHandler) in
            completionHandler(true)
       
        
        }
        
        save.backgroundColor = .systemBlue
        let swipe =  UISwipeActionsConfiguration(actions: [save])
        return swipe
    }
    
//    
//    func addCars(savedCoins:Memecoins){
//        let savedCoins = Memecoins(withDicitonary: <#[String : Any]#>)
//        
//            SaveManger.updateWith(favorite: savedCars, actionType: .add, key: SaveManger.Keys.favorites) { error in
//            guard error != nil else{
//                self.alert(message: "Saved", title: "")
//                return
//            }
//            self.alert(message: CFError.saveFailure.rawValue, title: "")
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memes", for: indexPath) as! MemecoinsTableViewCell
        var memeCoins: Memecoins
        if isFiltering{
            memeCoins = filteredMemecoins[indexPath.row]
        } else{
            memeCoins = memecoins[indexPath.row]
        }
        
        let priceInFlaot = Float(memeCoins.price)
        let formatedPrice = String(format: "$%.12f%", priceInFlaot!)
        cell.coinName.text = memeCoins.name.trunc(length: 29)
        cell.memeprice.text = formatedPrice
        cell.tickerSymbol.text = memeCoins.simple
        return cell
    }
    
}

extension MemecoinsVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!, memecoins)
    }
    
    func filterContentForSearchText(_ searchText:String, _ array:[Memecoins]){
        filteredMemecoins =  memecoins.filter({ (memes: Memecoins) -> Bool in
                                                return (memes.simple.lowercased().contains(searchText.lowercased()) ) })
        tableView.reloadData()
    }
    
}
