//
//  WatchListViewController.swift
//  Memecoins
//
//  Created by Alex Paul on 8/9/21.
//

import UIKit

class WatchListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var coins = [Memecoins]()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteCoins()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getFavoriteCoins(){
        SaveManger.collectFavorties{ [weak self ] result in
            guard let self = self else { return}
            switch result{
            
            case .success(let favorites):
                self.coins = favorites
                DispatchQueue.main.async{self.tableView.reloadData()}
                
            case .failure( _):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot", message:"Something went wrong" ,preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            
            
        }
        
    }
    
    

}

extension WatchListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell 2") as! WatchListTableViewCell
        let coin = coins[indexPath.row]
        
        cell.textLabel?.text = coin.name
        cell.textLabel?.text = coin.price
        cell.textLabel?.text = coin.price_BNB
        cell.textLabel?.text = coin.simple
       
       return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = coins[indexPath.row]
        coins.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        SaveManger.updateWith(favorite: favorite, actionType: .remove, key: SaveManger.Keys.favorites) { [weak self] error in
            guard self != nil else { return }
            guard error != nil else { return }
            
        }
        
    }
    
    
}
