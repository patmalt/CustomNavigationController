
import UIKit

class Animatior: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let destination = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else
        {
            return transitionContext.completeTransition(false)
        }
        let container = transitionContext.containerView
        
        let snapshot = destination.view.snapshotView(afterScreenUpdates: true) ?? UIView()
        
        source.beginAppearanceTransition(false, animated: true)
        destination.beginAppearanceTransition(true, animated: true)
        
        container.addSubview(snapshot)
        snapshot.frame = CGRect(origin: CGPoint(x: container.frame.maxX, y: 0), size: container.frame.size)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                snapshot.frame.origin.x = 0
            })
        }) { (completed) in
            container.addSubview(destination.view)
            snapshot.removeFromSuperview()
            
            source.endAppearanceTransition()
            destination.endAppearanceTransition()
            
            transitionContext.completeTransition(completed)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
}
