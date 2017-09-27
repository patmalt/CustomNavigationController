
import UIKit

class PopAnimatior: Animatior {
    override func add(view destination: UIView, to container: UIView, with source: UIView) {
        container.insertSubview(destination, belowSubview: source)
    }
}
