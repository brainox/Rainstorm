//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.stringIdentifier) as? DayViewController else {
            fatalError("Unable to Instantiate Day View Controller")
        }
        
        // Configure Day View Controller
        dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return dayViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.stringIdentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Week View Controller")
        }
        
        // Configure Day View Controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return weekViewController
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controller
        setupViewChildViewControllers()
    }
    
    // MARK: - Helper Methods
    
    func setupViewChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dayViewController.view.heightAnchor.constraint(equalToConstant: Layout.DayView.height).isActive = true
        
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchWeatherData = { [weak self] (data, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self?.presentAlert(of: .noWeatherDataAvailable)
                }
            } else if let data = data {
                print(data)
            } else {
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
            
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}

extension RootViewController {
    
    fileprivate enum Layout {
        enum DayView {
            static let height: CGFloat = 200.0
        }
    }
}
