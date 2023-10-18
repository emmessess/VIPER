//
//  Presenter.swift
//  VIPER Arch Demo
//
//  Created by Muhammad on 13/10/2023.
//

import Foundation
    // Ties everything
// Reference of Interactor, Router and View

enum FetchError : Error {
    case failed
}

protocol AnyPresenter  {
    var router : AnyRouter?{get set}
    var interactor : AnyInteractor?{get set}
    var view : AnyView?{get set}
    
    func interactorDidFetchUsers(with results:Result<[User],Error>)
}
class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.getUser()
        }
    }
    
    var view: AnyView?
    
    init(){
        interactor?.getUser()
        //Initally interactor is nil that's getUser is not called
    }
    
    func interactorDidFetchUsers(with results: Result<[User], Error>) {
        switch results {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    
}
