
import UIKit

class PatNavigationController: UIViewController {
    private var viewControllers: [NavigationWrapperView]
    
    init(rootViewController: UIViewController) {
        self.viewControllers = [NavigationWrapperView(viewController: rootViewController)]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let rootView = UIView()
        rootView.backgroundColor = .green
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRootViewController()
    }
    
    func push(viewController toViewController: UIViewController) {
        guard isViewLoaded, let fromWrapperView = viewControllers.last else {
            return
        }
        let fromViewController = fromWrapperView.viewController
        
        fromViewController.willMove(toParentViewController: nil)
        addChildViewController(toViewController)
        
        toViewController.title = "\(viewControllers.count)"
        let toWrapperView = NavigationWrapperView(viewController: toViewController, navigationController: self)
        viewControllers.append(toWrapperView)
        addNavigationWrapperView(toWrapperView)
        
        fromWrapperView.removeFromSuperview()
        
        fromViewController.removeFromParentViewController()
        toViewController.didMove(toParentViewController: self)
    }
    
    @objc
    func popViewController() {
        guard viewControllers.count > 1,
            let fromWrapperView = viewControllers.popLast(),
            let toWrapperView = viewControllers.last else
        {
            return
        }
        let fromViewController = fromWrapperView.viewController
        let toViewController = toWrapperView.viewController

        fromViewController.willMove(toParentViewController: nil)
        toViewController.willMove(toParentViewController: self)
        addChildViewController(toViewController)
        
        addNavigationWrapperView(toWrapperView)
        fromWrapperView.removeFromSuperview()
        
        fromViewController.removeFromParentViewController()
        toViewController.didMove(toParentViewController: self)
    }
    
    private func addNavigationWrapperView(_ wrapperView: NavigationWrapperView) {
        view.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(
            [
                wrapperView.topAnchor.constraint(equalTo: view.topAnchor),
                wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                wrapperView.leftAnchor.constraint(equalTo: view.leftAnchor),
                wrapperView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ]
        )
    }
    
    private func displayRootViewController() {
        guard let wrapperView = viewControllers.first else {
            return
        }
        addChildViewController(wrapperView.viewController)
        addNavigationWrapperView(wrapperView)
        wrapperView.viewController.didMove(toParentViewController: self)
    }
}
