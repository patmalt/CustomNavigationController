
import UIKit

class ViewController: UIViewController {
    let color: UIColor
    
    init(color: UIColor = .red) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = color
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(GestureRecognizer)
    }
    
    @objc
    private func tap() {
        patNavigationController?.push(viewController: ViewController(color: .blue))
    }
}

extension UIViewController {
    var patNavigationController: PatNavigationController? {
        guard let patNavigationController = self.parent as? PatNavigationController else {
            return nil
        }
        return patNavigationController
    }
}
