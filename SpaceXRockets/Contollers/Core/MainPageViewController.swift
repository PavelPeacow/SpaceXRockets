//
//  MainPageViewController.swift
//  SpaceXRockets
//
//  Created by Павел Кай on 02.11.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    private var rockets = [RocketModel]()
    private var viewPages = [RocketViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        getRockets()
        
        setDelegates()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        delegate = self
        dataSource = self
    }
    
}

extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        4
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = viewPages.firstIndex(of: viewController as! RocketViewController) else { return nil }
        
        if currentIndex == 0 { return viewPages.last }
        else { return viewPages[currentIndex - 1] }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = viewPages.firstIndex(of: viewController as! RocketViewController) else { return nil }
        
        if currentIndex < viewPages.count - 1 { return viewPages[currentIndex + 1] }
        else { return viewPages.first }
    }
}

extension MainPageViewController {
    
    func getRockets() {
        APIManager.shared.getRockets { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.rockets = success
                    
                    for rocket in self!.rockets {
                        let page = RocketViewController()
                        page.configure(with: rocket)
                        self?.viewPages.append(page)
                    }
                    
                    self?.setViewControllers([self!.viewPages[0]], direction: .forward, animated: true)
                    print(self?.rockets as Any)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

