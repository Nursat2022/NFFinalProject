//
//  PageViewController.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    let roundedRectangle: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Fast shipping"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Get all of your desired sneakers in one place."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 27
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func setup() {
        [roundedRectangle, label, subLabel, stackView, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        button.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        
        let page1 = OnboardingViewController(firstImageName: "page1Sneakers1", secondImageName: "page1Sneakers2", vectorImageName: "page1Vector")
        let page2 = OnboardingViewController(firstImageName: "page2Sneakers1", secondImageName: "page2Sneakers2", vectorImageName: "page2Vector")
        let page3 = OnboardingViewController(firstImageName: "page3Sneakers1", secondImageName: "page3Sneakers2", vectorImageName: "page3Vector")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
        roundedRectangle.image = UIImage(named: "RoundedRect1")
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func updateUI() {
        roundedRectangle.image = UIImage(named: "RoundedRect\(pageControl.currentPage + 1)")
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(subLabel)
        stackView.addArrangedSubview(button)
        view.addSubview(roundedRectangle)
        view.addSubview(pageControl)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 30),
            
            roundedRectangle.leftAnchor.constraint(equalTo: view.leftAnchor),
            roundedRectangle.rightAnchor.constraint(equalTo: view.rightAnchor),
            roundedRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roundedRectangle.heightAnchor.constraint(equalToConstant: h * CGFloat(288/844.0)),
            
            stackView.centerYAnchor.constraint(equalTo: roundedRectangle.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: roundedRectangle.centerXAnchor),
            
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: h * CGFloat(54/844.0))
        ])
    }
}

extension PageViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        updateUI()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        print(pageControl.currentPage)
        if pageControl.currentPage == 2 {
            UserDefaults.standard.set(true, forKey: "isOnboardingSeen")
            let welcomeViewController = WelcomeViewController()
            self.navigationController?.pushViewController(welcomeViewController, animated: true)
        }
        else {
            pageControl.currentPage += 1
            goToNextPage()
            updateUI()
        }
    }

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        updateUI()
    }
}
