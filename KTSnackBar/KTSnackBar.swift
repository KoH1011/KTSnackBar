//
//  KTSnackBar.swift
//  KTSnackBar
//
//  Created by KoH1011 on 2018/02/01.
//  Copyright © 2018年 KoH1011. All rights reserved.
//

import Foundation

public enum KTSnackBarOption {
    case width(CGFloat)
    case height(CGFloat)
    case font(UIFont)
    case interval(Double)
}

open class KTSnackBar: UIView {
    
    open var willShowHandler: (() -> ())?
    open var willDismissHandler: (() -> ())?
    open var didShowHandler: (() -> ())?
    open var didDismissHandler: (() -> ())?
    open var pressedBlock: (() -> ())?
    
    fileprivate var yPosition: CGFloat {
        get {
            return UIScreen.main.bounds.maxY - self.height
        }
    }
    
    fileprivate var containerView: UIView!
    fileprivate var contentView: UIView!
    fileprivate var contentViewFrame: CGRect {
        get {
            return CGRect(x: (UIScreen.main.bounds.width - self.width) / 2, y: self.yPosition, width: self.width, height: self.height)
        }
    }
    
    open var width: CGFloat = UIScreen.main.bounds.width
    open var height: CGFloat = 48.0
    open var font: UIFont = UIFont()
    open var interval: Double = 1.0
    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    public init(showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        super.init(frame: CGRect.zero)
        
        self.didShowHandler = showHandler
        self.didDismissHandler = dismissHandler
    }
    
    public init(options: [KTSnackBarOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
        super.init(frame: CGRect.zero)
        
        self.setOptions(options)
        self.didShowHandler = showHandler
        self.didDismissHandler = dismissHandler
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func show(message: String) {
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }
        
        self.createContainerView()
        self.show(rootView, t: message)
        self.createTimer()
    }
    
    open func show(buttonText: String) {
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }
        self.createContainerView()
        self.show(rootView, bt: buttonText)
    }
    
    open func show(aView: UIView) {
        guard let rootView = UIApplication.shared.keyWindow else {
            return
        }
        self.createContainerView()
        self.show(rootView, aView: aView)
    }
    
    private func show(_ rootView: UIView, t: String) {
        
        let label = self.createLabel(t: t)
        self.containerView.addSubview(label)
        
        rootView.addSubview(self.containerView)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseOut, animations: {
            label.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseOut, animations: {
            label.alpha = 1
        }) { _ in
            self.didShowHandler?()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.containerView.frame = CGRect(x: self.contentViewFrame.minX, y: UIScreen.main.bounds.height - self.height, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        }, completion: nil)
    }
    
    private func show(_ rootView: UIView, bt: String) {
        
        let button = self.createButton(t: bt)
        
        self.containerView.addSubview(button)
        
        rootView.addSubview(self.containerView)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseOut, animations: {
            button.alpha = 1
        }) { _ in
            self.didShowHandler?()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.containerView.frame = CGRect(x: self.contentViewFrame.minX, y: UIScreen.main.bounds.height - self.height, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        }) { _ in
            self.didShowHandler?()
        }
    }
    
    private func show(_ rootView: UIView, aView: UIView) {
        self.containerView.addSubview(aView)
        
        rootView.addSubview(self.containerView)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.containerView.frame = CGRect(x: self.contentViewFrame.minX, y: UIScreen.main.bounds.height - self.height, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        }) { _ in
            self.didShowHandler?()
        }
    }
    
    private func createContainerView() {
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: self.contentViewFrame.minX, y: UIScreen.main.bounds.height, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        self.containerView.backgroundColor = UIColor.gray
    }
    
    private func createLabel(t: String) -> UILabel {
        let label = UILabel()
        label.text = t
        label.textColor = UIColor.white
        label.frame = CGRect(x: 8, y: 0, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        label.alpha = 0
        label.textAlignment = .center
        
        return label
    }
    
    private func createButton(t: String) -> UIButton {
        let button = UIButton()
        button.setTitle(t, for: .normal)
        button.tintColor = UIColor.white
        button.frame = CGRect(x: 8, y: 0, width: self.contentViewFrame.width, height: self.contentViewFrame.height)
        button.alpha = 0
        button.addTarget(self, action: #selector(KTSnackBar.didTapButton), for: .touchUpInside)
        
        return button
    }
    
    private func createTimer() {
        Timer.scheduledTimer(timeInterval: self.interval,
                             target: self,
                             selector: #selector(KTSnackBar.dismiss),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc private func didTapButton() {
        self.pressedBlock?()
        self.dismiss()
    }
    
    @objc open func dismiss() {
        
        if !self.containerView.isHidden {
            
            let frame = self.containerView.frame
            self.containerView.frame = CGRect(x: frame.minX, y: UIScreen.main.bounds.height - self.height, width: frame.width, height: frame.height)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: frame.minX, y: UIScreen.main.bounds.height, width: frame.width, height: frame.height)
            }) { _ in
                self.containerView.isHidden = true
                self.didDismissHandler?()
            }
        }
    }
    
    private func setOptions(_ options: [KTSnackBarOption]?) {
        if let options = options {
            for option in options {
                switch option {
                case let .width(value):
                    self.width = value
                case let .height(value):
                    self.height = value
                case let .font(value):
                    self.font = value
                case let .interval(value):
                    self.interval = value
                }
            }
        }
    }
}

