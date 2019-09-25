import UIKit

extension UIView {
    func pinFullscreen(to parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func drawShadow(withOffset offset: CGSize, radius: CGFloat, opacity: CGFloat, color: UIColor = .black) {
        layer.masksToBounds = false
        let shadowPath = UIBezierPath(rect: bounds)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)
    }
}
