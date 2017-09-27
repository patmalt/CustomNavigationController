
import UIKit

class PushTransitionContext: TransitionContext {
    override func initialFrame(for vc: UIViewController) -> CGRect {
        if vc == self.viewController(forKey: .from) {
            return containerView.frame
        } else if vc == self.viewController(forKey: .to) {
            let frame = containerView.frame
            let origin = CGPoint(x: frame.width, y: frame.origin.y)
            return CGRect(origin: origin, size: frame.size)
        } else {
            return CGRect.zero
        }
    }
    
    override func finalFrame(for vc: UIViewController) -> CGRect {
        if vc == self.viewController(forKey: .from) {
            return containerView.frame
        } else if vc == self.viewController(forKey: .to) {
            return containerView.frame
        } else {
            return CGRect.zero
        }
    }
}
