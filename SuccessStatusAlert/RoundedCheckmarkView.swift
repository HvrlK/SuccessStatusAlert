//
//  RoundedCheckmarkView.swift
//  SuccessStatusAlert
//
//  Created by Vitalii Havryliuk on 25.09.2019.
//

import UIKit

final class RoundedCheckmarkView: UIView {
    
    func showCheckmark(color: UIColor, animated: Bool) {
        let borderAnimationDuration: TimeInterval = animated ? 0.2 : 0
        let checkmarkAnimationDuration: TimeInterval = animated ? 0.2 : 0
        showCheckmark(color: color, borderAnimationDuration: borderAnimationDuration, checkmarkAnimationDuration: checkmarkAnimationDuration)
    }
    
    private func showCheckmark(color: UIColor, borderAnimationDuration: TimeInterval, checkmarkAnimationDuration: TimeInterval) {
        let lineWidth: CGFloat = 2
        let halfLineWidth = lineWidth / 2
        let rect = bounds.insetBy(dx: halfLineWidth, dy: halfLineWidth)
        
        // Animate border
        
        let initialBorderPath = UIBezierPath(ovalIn: CGRect(x: rect.midX, y: rect.midY, width: 0, height: 0))
        let borderPath = UIBezierPath(ovalIn: rect)
        
        let borderShapeLayer = CAShapeLayer()
        borderShapeLayer.path = initialBorderPath.cgPath
        borderShapeLayer.lineWidth = lineWidth
        borderShapeLayer.strokeColor = color.cgColor
        borderShapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderShapeLayer)
        
        let borderAnimation = CABasicAnimation(keyPath: "path")
        borderAnimation.duration = borderAnimationDuration
        borderAnimation.fromValue = initialBorderPath.cgPath
        borderAnimation.toValue = borderPath.cgPath
        borderAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        borderAnimation.fillMode = CAMediaTimingFillMode.forwards
        borderAnimation.isRemovedOnCompletion = false
        borderShapeLayer.add(borderAnimation, forKey: "borderAnimation")
        
        // Animate checkmark
        
        let checkmarkWidth: CGFloat = 10
        let checkmarkHeight: CGFloat = 7.15
        let checkmarkHorizontalInsets: CGFloat = (bounds.width - checkmarkWidth) / 2
        let checkmarkVerticalInsets: CGFloat = (bounds.height - checkmarkHeight) / 2
        let checkmarkRect = rect.insetBy(dx: checkmarkHorizontalInsets, dy: checkmarkVerticalInsets)

        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: checkmarkRect.minX, y: checkmarkRect.midY))
        checkmarkPath.addLine(to: CGPoint(x: checkmarkRect.minX + 0.333 * checkmarkRect.width, y: checkmarkRect.maxY))
        checkmarkPath.addLine(to: CGPoint(x: checkmarkRect.maxX, y: checkmarkRect.minY))
        
        let checkmarkShapeLayer = CAShapeLayer()
        checkmarkShapeLayer.path = checkmarkPath.cgPath
        checkmarkShapeLayer.strokeColor = color.cgColor
        checkmarkShapeLayer.fillColor = UIColor.clear.cgColor
        checkmarkShapeLayer.lineWidth = lineWidth
        checkmarkShapeLayer.lineCap = CAShapeLayerLineCap.round
        checkmarkShapeLayer.lineJoin = CAShapeLayerLineJoin.round
        checkmarkShapeLayer.strokeEnd = 0
        layer.addSublayer(checkmarkShapeLayer)
        
        let checkmarkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkmarkAnimation.beginTime = CACurrentMediaTime() + borderAnimationDuration
        checkmarkAnimation.toValue = 1
        checkmarkAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        checkmarkAnimation.duration = checkmarkAnimationDuration
        checkmarkAnimation.fillMode = CAMediaTimingFillMode.forwards
        checkmarkAnimation.isRemovedOnCompletion = false
        checkmarkShapeLayer.add(checkmarkAnimation, forKey: "animateCheckmark")
    }
}
