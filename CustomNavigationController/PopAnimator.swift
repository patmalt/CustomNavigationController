
import UIKit

class PopAnimatior: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
            let sourceView = transitionContext.view(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to),
            let destinationView = transitionContext.view(forKey: .to) else
        {
            return transitionContext.completeTransition(false)
        }
        let container = transitionContext.containerView
        
        source.beginAppearanceTransition(false, animated: true)
        sourceView.frame = transitionContext.initialFrame(for: source)
        
        destinationView.isUserInteractionEnabled = false
        destination.beginAppearanceTransition(true, animated: true)
        container.insertSubview(destinationView, belowSubview: sourceView)
        destinationView.frame = transitionContext.initialFrame(for: destination)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                sourceView.frame = transitionContext.finalFrame(for: source)
                destinationView.frame = transitionContext.finalFrame(for: destination)
            })
        }) { (completed) in
            destinationView.isUserInteractionEnabled = true
            source.endAppearanceTransition()
            destination.endAppearanceTransition()
            transitionContext.completeTransition(completed)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
}
