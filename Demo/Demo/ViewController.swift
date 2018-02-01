//
//  ViewController.swift
//  Demo
//
//  Created by KoH1011 on 2018/02/01.
//  Copyright © 2018年 KoH1011. All rights reserved.
//

import UIKit
import KTSnackBar

class ViewController: UIViewController {
    
    @IBOutlet weak var timerShowButton: UIButton! {
        didSet {
            self.timerShowButton.addTarget(
                self,
                action: #selector(ViewController.didTapTimerShowButton),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var defaultButton: UIButton! {
        didSet {
            self.defaultButton.addTarget(
                self,
                action: #selector(ViewController.didTapDefaultButton),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var customButton: UIButton! {
        didSet {
            self.customButton.addTarget(
                self,
                action: #selector(ViewController.didTapCustomButton),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            self.dismissButton.addTarget(
                self,
                action: #selector(ViewController.didTapDismissButton),
                for: .touchUpInside)
        }
    }
    
    fileprivate var snackBar: KTSnackBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupEnabled(for bool: Bool) {
        self.customButton.isEnabled = bool
        self.defaultButton.isEnabled = bool
        self.dismissButton.isEnabled = bool
        self.timerShowButton.isEnabled = bool
    }
    
    // Action
    
    @objc func didTapTimerShowButton() {
        
        let option = [
            .width(UIScreen.main.bounds.width),
            .height(40.0),
            .interval(3)
            ] as [KTSnackBarOption]
        self.snackBar = KTSnackBar(options: option, showHandler: {
            print("timer show")
        }, dismissHandler: {
            print("timer dismiss")
        })
        snackBar.show(message: "Timer Dissmiss!")
    }
    
    @objc func didTapDefaultButton() {
        self.snackBar = KTSnackBar()
        self.snackBar.show(buttonText: "Tap Dissmiss!")
        self.setupEnabled(for: false)
        self.snackBar.pressedBlock = {
            print("Dismiss!")
            self.setupEnabled(for: true)
        }
    }
    
    @objc func didTapCustomButton() {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
        let option = [
            .height(20)
            ] as [KTSnackBarOption]
        self.snackBar = KTSnackBar(options: option, showHandler: {
            print("custom show")
        }) {
            print("custom dismiss")
        }
        snackBar.show(aView: view)
    }
    
    @objc func didTapDismissButton() {
        guard let snackBar = self.snackBar else { return }
        snackBar.dismiss()
    }
}

