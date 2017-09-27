
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
        
        let animator = PushAnimatior()
        let context = PushTransitionContext(rootView: view,
                                            fromWrapper: fromWrapperView,
                                            toWrapper: toWrapperView)
        context.completion = { completed in
            self.viewControllers.append(toWrapperView)
            
            fromWrapperView.removeFromSuperview()
            
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
        }
        animator.animateTransition(using: context)
    }
    
    @objc
    func popViewController() {
        let count = viewControllers.count
        guard count > 1 else {
            return
        }
        let fromWrapperView = viewControllers[count - 1]
        let fromViewController = fromWrapperView.viewController
        
        let toWrapperView = viewControllers[count - 2]
        let toViewController = toWrapperView.viewController
        
        fromViewController.willMove(toParentViewController: nil)
        addChildViewController(toViewController)
        
        let animator = PopAnimatior()
        let context = PopTransitionContext(rootView: view,
                                           fromWrapper: fromWrapperView,
                                           toWrapper: toWrapperView)
        context.completion = { completed in
            _ = self.viewControllers.popLast()
            
            fromWrapperView.removeFromSuperview()
            
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
        }
        animator.animateTransition(using: context)
    }
    
    private func displayRootViewController() {
        guard let wrapperView = viewControllers.first else {
            return
        }
        addChildViewController(wrapperView.viewController)
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
        wrapperView.viewController.didMove(toParentViewController: self)
    }
}
