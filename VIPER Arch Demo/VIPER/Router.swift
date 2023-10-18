//
//  Router.swift
//  VIPER Arch Demo
//
//  Created by Muhammad on 13/10/2023.
//

import Foundation
// Object
//No reference of any other component
// Route with in it's own module
// Entry Point
import UIKit
typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter{
    var entry : EntryPoint? { get }
    // OR without typeAliasing
//    var entry : AnyView & UIViewController? { get }

    static func start() -> AnyRouter
}
class UserRouter:AnyRouter{
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        // Assign VIP here
        var view : AnyView = UserViewController()
        var presenter : AnyPresenter = UserPresenter()
        var interactor : AnyInteractor = UserInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        return router
    }
}
