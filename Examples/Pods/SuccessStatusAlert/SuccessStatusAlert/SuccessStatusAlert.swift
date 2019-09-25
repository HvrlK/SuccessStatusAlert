//
//  SuccessStatusAlert.swift
//  SuccessStatusAlert
//
//  Created by Vitalii Havryliuk on 25.09.2019.
//

import UIKit

@IBDesignable
final public class SuccessStatusAlert: UIView {
    
    // MARK: Outlets
    
    @IBOutlet weak var checkmarkView: RoundedCheckmarkView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var shadowView: UIView!
    
    // MARK: Properties
       
    private let heightConstant: CGFloat = 50
    private let cornerRadius: CGFloat = 25
    private var debouncedHiding: ((TimeInterval) -> Void)!
    
    fileprivate let defaultFadeAnimationDuration: TimeInterval = TimeInterval(UINavigationController.hideShowBarDuration)
    
    @IBInspectable
    public dynamic var contentBackgroundColor: UIColor? = .white {
        didSet {
            shadowView.backgroundColor = contentBackgroundColor
        }
    }
    
    @IBInspectable
    public dynamic var visualEffect: UIVisualEffect? = UIBlurEffect(style: .regular) {
        didSet {
            visualEffectView.effect = visualEffect
        }
    }
    
    @IBInspectable
    public dynamic var titleColor: UIColor? = .systemGray {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    @IBInspectable
    public dynamic var descriptionColor: UIColor? = .gray {
        didSet {
            descriptionLabel.textColor = descriptionColor
        }
    }
    
    // MARK: Private Methods
            
    fileprivate func configureView(in parent: UIView, title: String, description: String?, duration: TimeInterval) {
        visualEffectView.layer.cornerRadius = cornerRadius
        visualEffectView.layer.masksToBounds = true
       
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.masksToBounds = false
        shadowView.alpha = 0.9
        titleLabel.text = title
        
        if let description = description {
            descriptionLabel.text = description
            titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        } else {
            descriptionLabel.isHidden = true
        }
    
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: parent.topAnchor),
            centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            widthAnchor.constraint(equalToConstant: 195),
            heightAnchor.constraint(equalToConstant: heightConstant),
        ])
        
        let animationDuration = defaultFadeAnimationDuration
        debouncedHiding = debounce(interval: duration, queue: DispatchQueue.main) { [weak self] _ in
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.identity
                }, completion: { [weak self] _ in
                    self?.removeFromSuperview()
            })
        }
    }
    
    fileprivate func showCheckmark(animated: Bool) {
        let topConstant = UIApplication.shared.statusBarFrame.height
        let color = tintColor!
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.transform = CGAffineTransform(translationX: 0, y: self.heightConstant + topConstant)
            }, completion: { [weak self] _ in
                self?.checkmarkView.showCheckmark(color: color, animated: animated)
        })
        
    }
    
    fileprivate func hideAlert(delay: TimeInterval) {
        debouncedHiding(delay)
    }
    
}

// MARK: - Functions

fileprivate typealias Debounce<T> = (_ : T) -> Void

fileprivate func debounce<T>(interval: TimeInterval, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + interval

        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + interval
            let now = DispatchTime.now()
            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}

// MARK: - Extensions

fileprivate extension UIWindow {
    func showSuccessStatusAlert(title: String, description: String?, duration: TimeInterval) {
        if let statusAlert = self.subviews.first(where: { $0 is SuccessStatusAlert }) as? SuccessStatusAlert  {
            statusAlert.hideAlert(delay: duration)
        } else {
            let statusAlert = UINib(nibName: String(describing: SuccessStatusAlert.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SuccessStatusAlert
            statusAlert.configureView(in: self, title: title, description: description, duration: duration)
            statusAlert.showCheckmark(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + statusAlert.defaultFadeAnimationDuration) { [weak statusAlert] in
                statusAlert?.hideAlert(delay: duration)
            }
        }
    }
}

public extension UIViewController {
    func showSuccessStatusAlert(title: String, description: String? = nil, duration: TimeInterval = 2) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        window.showSuccessStatusAlert(title: title, description: description, duration: duration)
    }
}
