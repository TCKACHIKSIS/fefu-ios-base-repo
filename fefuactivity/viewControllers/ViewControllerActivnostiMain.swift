//
//  ViewControllerActivnostiMain.swift
//  fefuactivity
//
//  Created by иван on 28.10.2021.
//

import UIKit

class ViewControllerActivnosiMain: UIViewController {
    @IBOutlet weak var table_with_activnosti: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_with_activnosti.dataSource = self
        registerCell()
    }
    private func registerCell(){
        table_with_activnosti.register(UINib(nibName: "OneStatementInActivityTableViewCell" , bundle: nil), forCellReuseIdentifier: String(describing: OneStatementInActivityTableViewCell.self))
    }
}


extension ViewControllerActivnosiMain: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OneStatementInActivityTableViewCell", for:indexPath ) as? OneStatementInActivityTableViewCell{
            return cell
        } else {
            assert(false)
            return UITableViewCell()
        }
        
    }
    
    
}
