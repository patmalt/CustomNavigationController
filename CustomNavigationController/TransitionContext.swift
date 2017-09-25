
import UIKit

class TransitionContext: NSObject, UIViewControllerContextTransitioning {
    var completion: ((Bool) -> ())?
    var isAnimated: Bool = true
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    var presentationStyle: UIModalPresentationStyle = .custom
    func updateInteractiveTransition(_ percentComplete: CGFloat) {}
    func finishInteractiveTransition() {}
    func cancelInteractiveTransition() {}
    func pauseInteractiveTransition() {}
    
    func completeTransition(_ didComplete: Bool) {
        completion?(didComplete)
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        if key == UITransitionContextViewControllerKey.to {
            return toWrapper.viewController
        } else if key == UITransitionContextViewControllerKey.from {
            return fromWrapper.viewController
        }
        return nil
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }
    
    var targetTransform: CGAffineTransform = .identity
    
    func initialFrame(for vc: UIViewController) -> CGRect {
        return CGRect.zero
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        return CGRect.zero
    }
    
    private let fromWrapper: NavigationWrapperView
    private let toWrapper: NavigationWrapperView
    
    init(fromWrapper: NavigationWrapperView, toWrapper: NavigationWrapperView) {
        self.fromWrapper = fromWrapper
        self.toWrapper = toWrapper
        super.init()
    }
    
    var containerView: UIView {
        return fromWrapper.superview!
    }
}
