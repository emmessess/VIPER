//
//  Interactor.swift
//  VIPER Arch Demo
//
//  Created by Muhammad on 13/10/2023.
//

import Foundation
// Object required ref to presenter
protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    
    func getUser()// No Complettion because it will notify presenter once ready
    
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUser() {
        print("Start Fetching")
        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let url = URL(string: urlString)  else { return }
        let task = URLSession.shared.dataTask(with: url){[weak self] data,_,error  in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            do{
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
                
            }
            catch{
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }
        }
        task.resume()
    }
    
    
}
