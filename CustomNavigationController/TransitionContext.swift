
import UIKit

class TransitionContext: NSObject, UIViewControllerContextTransitioning {
    var completion: ((Bool) -> ())?
    var isAnimated: Bool = true
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    var presentationStyle: UIModalPresentationStyle = .custom
    var targetTransform: CGAffineTransform = .identity
    private let rootView: UIView
    private let fromWrapper: NavigationWrapperView
    private let toWrapper: NavigationWrapperView
    private let isPush: Bool
    
    init(rootView: UIView, fromWrapper: NavigationWrapperView, toWrapper: NavigationWrapperView, isPush: Bool) {
        self.rootView = rootView
        self.fromWrapper = fromWrapper
        self.toWrapper = toWrapper
        self.isPush = isPush
        super.init()
    }
    
    func completeTransition(_ didComplete: Bool) {
        completion?(didComplete)
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case .to:
            return toWrapper.viewController
        case .from:
            return fromWrapper.viewController
        default:
            return nil
        }
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case .to:
            return toWrapper
        case .from:
            return fromWrapper
        default:
            return nil
        }
    }
    
    func initialFrame(for vc: UIViewController) -> CGRect {
        if isPush {
            if vc == self.viewController(forKey: .from) {
                return containerView.frame
            } else if vc == self.viewController(forKey: .to) {
                let frame = containerView.frame
                let origin = CGPoint(x: frame.width, y: frame.origin.y)
                return CGRect(origin: origin, size: frame.size)
            } else {
                return CGRect.zero
            }
        } else {
            if vc == self.viewController(forKey: .from) {
                return containerView.frame
            } else if vc == self.viewController(forKey: .to) {
                return containerView.frame
            } else {
                return CGRect.zero
            }
        }
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        if isPush {
            if vc == self.viewController(forKey: .from) {
                return containerView.frame
            } else if vc == self.viewController(forKey: .to) {
                return containerView.frame
            } else {
                return CGRect.zero
            }
        } else {
            if vc == self.viewController(forKey: .from) {
                let frame = containerView.frame
                let origin = CGPoint(x: frame.width, y: frame.origin.y)
                return CGRect(origin: origin, size: frame.size)
            } else if vc == self.viewController(forKey: .to) {
                return containerView.frame
            } else {
                return CGRect.zero
            }
        }
    }
    
    var containerView: UIView {
        return rootView
    }
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {}
    func finishInteractiveTransition() {}
    func cancelInteractiveTransition() {}
    func pauseInteractiveTransition() {}
}
