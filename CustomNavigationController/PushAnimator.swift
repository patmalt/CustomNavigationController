
import UIKit

class PushAnimatior: Animatior {
    override func add(view destination: UIView, to container: UIView, with source: UIView) {
        container.insertSubview(destination, aboveSubview: source)
    }
}
