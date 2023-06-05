//
//  PageViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var views = [OnboardingHelper]()
    let firstImage1 = UIImage(named: "image1")
    let secondImage1 = UIImage(named: "image2")
    let firstImage2 = UIImage(named: "image3")
    let secondImage2 = UIImage(named: "image4")
    let firstImage3 = UIImage(named: "image5")
    let secondImage3 = UIImage(named: "image6")
    let vectorImage1 = UIImage(named: "vector1")
    let vectorImage2 = UIImage(named: "vector2")
    let vectorImage3 = UIImage(named: "vector3")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let firstView = OnboardingHelper(firstImage: firstImage1!, secondImage: secondImage1!, vectorImage: vectorImage1!)
        let secondView = OnboardingHelper(firstImage: firstImage2!, secondImage: secondImage2!, vectorImage: vectorImage2!)
        let thirdView = OnboardingHelper(firstImage: firstImage3!, secondImage: secondImage3!, vectorImage: vectorImage3!)
        
        views.append(firstView)
        views.append(secondView)
        views.append(thirdView)
        
        setViewControllers([OnboradingViewControllers[0]], direction: .forward, animated: true)
        self.dataSource = self
        self.delegate = self
    }
    
    lazy var OnboradingViewControllers: [TestViewController] = {
        var VC = [TestViewController]()
        for v in views {
            VC.append(TestViewController(helper: v))
        }
        return VC
    }()
    
//    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
//        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
//        setViewControllers([OnboradingViewControllers[0]], direction: .forward, animated: true)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? TestViewController else { return nil }
        if let index = OnboradingViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return OnboradingViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? TestViewController else { return nil }
        if let index = OnboradingViewControllers.firstIndex(of: viewController) {
            if index < OnboradingViewControllers.count - 1 {
                return OnboradingViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return OnboradingViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
