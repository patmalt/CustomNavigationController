
import UIKit

class NavigationWrapperView: UIView {
    let viewController: UIViewController
    let navigationBar: UINavigationBar
    weak var navigationController: PatNavigationController?
    
    init(viewController: UIViewController,
         navigationController: PatNavigationController? = nil)
    {
        self.viewController = viewController
        self.navigationBar = UINavigationBar()
        self.navigationController = navigationController
        super.init(frame: .zero)
        commonInit(showBack: navigationController != nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(showBack: Bool) {
        let navigationItem = UINavigationItem(title: viewController.title ?? "")
        
        if showBack, let navigationController = navigationController {
            let back = UIBarButtonItem(title: "Back",
                                       style: .plain,
                                       target: navigationController,
                                       action: #selector(PatNavigationController.popViewController))
            navigationItem.leftBarButtonItem = back
        }
        
        navigationBar.setItems([navigationItem], animated: false)
        
        let view = viewController.view ?? UIView()
        addSubview(navigationBar)
        addSubview(view)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(
            [
                navigationBar.topAnchor.constraint(equalTo: topAnchor),
                navigationBar.leftAnchor.constraint(equalTo: leftAnchor),
                navigationBar.rightAnchor.constraint(equalTo: rightAnchor),
                navigationBar.heightAnchor.constraint(equalToConstant: 44),
                view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
