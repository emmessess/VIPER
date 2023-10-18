//
//  View.swift
//  VIPER Arch Demo
//
//  Created by Muhammad on 13/10/2023.
//

import UIKit
// You can have a Viewcontroller instead we will have a protocol that has a reference of presenter
protocol AnyView {
    var presenter : AnyPresenter? {get set}
    
    func update(with users:[User])
    func update(with error:String)

}
class UserViewController: UIViewController, AnyView, UITableViewDataSource, UITableViewDelegate{
    
    var presenter: AnyPresenter?
    var users: [User] = []
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        self.view.backgroundColor = .systemBlue
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    func update(with users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        users = []
        DispatchQueue.main.async { [self] in
            tableView.isHidden = true
            label.text = error
            label.isHidden = false
        }
        print(error)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].names
        return cell
    }
    
}
