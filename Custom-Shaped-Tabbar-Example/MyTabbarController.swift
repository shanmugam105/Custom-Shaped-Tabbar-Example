//
//  MyTabbarController.swift
//  Custom-Shaped-Tabbar-Example
//
//  Created by Sparkout on 19/04/23.
//

import UIKit

class MyTabbar: UITabBar {
    
    var shapeLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let deviceSize: CGSize = UIScreen.main.bounds.size
        let tabBarSize: CGSize = CGSize(width: deviceSize.width, height: 60)
        return tabBarSize
    }
}

class MyTabbarController: UITabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        createShape(for: selectedIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 2
        createShape(for: self.selectedIndex)
        let tabbarAppearance: UITabBarAppearance = .init()
        tabbarAppearance.backgroundColor = .red
        self.tabBar.standardAppearance = tabbarAppearance
        self.tabBar.scrollEdgeAppearance = tabbarAppearance
    }
    
    private func createShape(for index: Int) {
        let tabbar: MyTabbar = self.tabBar as! MyTabbar
        let path = UIBezierPath()
        let padding: CGFloat = 5.0
        let curvePadding: CGFloat = 10.0
        let controlPointPadding: CGFloat = 5.0
        path.move(to: .init(x: padding + curvePadding, y: padding))
        let lineLength: CGFloat = tabbar.bounds.width - padding
        
        path.addLine(to: .init(x: lineLength - curvePadding, y: padding))
        // Corner Radius Curve 1
        path.addCurve(to: .init(x: lineLength, y: curvePadding), controlPoint1: .init(x: lineLength - controlPointPadding, y: padding), controlPoint2: .init(x: lineLength, y: padding + controlPointPadding))
        let lineHeight: CGFloat = tabbar.bounds.height - padding
        path.addLine(to: .init(x: lineLength, y: lineHeight - curvePadding))
        // Corner Radius Curve 2
        path.addCurve(to: .init(x: lineLength - curvePadding, y: lineHeight), controlPoint1: .init(x: lineLength, y: lineHeight - controlPointPadding), controlPoint2: .init(x: lineLength - controlPointPadding, y: lineHeight))
        path.addLine(to: .init(x: padding + curvePadding, y: lineHeight))
        // Corner Radius Curve 3
        path.addCurve(to: .init(x: padding, y: lineHeight - curvePadding), controlPoint1: .init(x: padding + controlPointPadding, y: lineHeight), controlPoint2: .init(x: padding, y: lineHeight - controlPointPadding))
        path.addLine(to: .init(x: padding, y: padding + curvePadding))
        // Corner Radius Curve 4
        path.addCurve(to: .init(x: padding + curvePadding, y: padding), controlPoint1: .init(x: padding, y: padding + controlPointPadding), controlPoint2: .init(x: padding + controlPointPadding, y: padding))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        
        if let oldShapeLayer = tabbar.shapeLayer {
            tabbar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            tabbar.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        tabbar.shapeLayer = shapeLayer
    }
}


