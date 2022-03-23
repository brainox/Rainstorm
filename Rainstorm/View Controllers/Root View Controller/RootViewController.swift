//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Properties
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
        
        fetchWeatherData()
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
    
    private func fetchWeatherData() {
        guard let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=9.0&exclude=minutely,alerts,hourly&lon=1.2&appid=96c1d443fdd0fbe9d24370ca1c886d26") else {
            return
        }
        
        URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            if let error = error {
                print(error)
            } else if let response = response {
                print(response)
            }
        }.resume()
//        let authenticatedBaseUrl = baseUrl.appendingPathComponent("96c1d443fdd0fbe9d24370ca1c886d26")
    }

}

extension RootViewController {
    
    fileprivate enum Layout {
        enum DayView {
            static let height: CGFloat = 200.0
        }
    }
}
