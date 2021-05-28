//
//  MemecoinsVC.swift
//  Memecoins
//
//  Created by Alex Paul on 5/23/21.
//

import UIKit

class MemecoinsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var memecoins = [String:Any]()
    let memesData = [String:MemecoinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getMemecoins()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
//    func memes(){
//        memesData.forEach { (key: String, value: MemecoinData) in
//            memecoins[key] = value
//        }
//    }
//
    func getMemecoins(){
        NetworkManger.shared.get(.tokens, urlString: "") { [weak self] (result: Result<[String:Any]?, ErroMessage> ) in
            guard let self = self else { return }
            switch result{
            case .success(_):
                self.memecoins = self.memesData
                print(self.memecoins)
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
        return memesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memes", for: indexPath) as! MemecoinsTableViewCell
        
        for (_, value) in memesData{
            cell.coinName.text = value.name
            cell.memeprice.text = value.price
            cell.tickerSymbol.text = value.symbol
            cell.address.text = String(value.hashValue)
        }
        
        return cell
    }
    
    
}
