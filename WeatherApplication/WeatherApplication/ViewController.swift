//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 27.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet var loginVloginTextFieldiew: UIView!
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var loginTitileView: UILabel!
    
    @IBOutlet weak var passwordTitleView: UILabel!
    
    
    var interactiveAnimator: UIViewPropertyAnimator!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)

        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // подписываемся на уведомления
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateTitlesAppearing()
        animateTitleAppearing()
        animateFieldsAppearing()
        animateAuthButton ()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // отписываемся от уведомлений
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow (notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let size = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: size.height, right: 0)
        
        self.scrollView?.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    @objc func keyboardWillHide (notification: Notification)
    {
        scrollView.contentInset = .zero
    }
    
    
    @objc func hideKeyboard ()
    {
        view.endEditing(true)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch identifier {
        case "loginSegue":
            
            let isAuth = login()
            
            if !isAuth {
                showErrorAlert()
            }
            
            return isAuth
        default:
            return true
        }
    }
    
    func login () -> Bool {
        // функция проверки учетных данных пользователя
        let login = loginTextField.text!
        let password = passwordTextField.text!
        return login == "admin" && password == "123456"
        
    }
    
    func showErrorAlert() {
        // вывод сообщения для пользователя
        // Создаем контроллер
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введены неверные данные пользователя",
            preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //       loginButton.layer.cornerRadius = 3
    }
    
    func animateTitlesAppearing() {
//        let offset = view.bounds.width
//        loginTitileView.transform = CGAffineTransform(translationX: -offset, y: 0)
//        passwordTitleView.transform = CGAffineTransform(translationX: offset, y: 0)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.loginTitileView.transform = .identity
//                        self.passwordTitleView.transform = .identity
//        },
//                       completion: nil)
        let offset = abs(self.loginTitileView.frame.midY - self.passwordTitleView.frame.midY)
                
        self.loginTitileView.transform = CGAffineTransform(translationX: 0, y: offset)
        self.passwordTitleView.transform = CGAffineTransform(translationX: 0, y: -offset)
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModeCubicPaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
             self.loginTitileView.transform = CGAffineTransform(translationX: 150, y: 50)
             self.passwordTitleView.transform = CGAffineTransform(translationX: -150, y: -50)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.5,
                                                       animations: {
             self.loginTitileView.transform = .identity
             self.passwordTitleView.transform = .identity
                                    })
        }, completion: nil)
    }
    
    func animateTitleAppearing() {
//        self.mainTitle.transform = CGAffineTransform(translationX: 0,
//                                                     y: -self.view.bounds.height/2)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.mainTitle.transform = .identity
//        },
//                       completion: nil)
        self.mainTitle.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height / 2)

        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: {
                                                  self.mainTitle.transform = .identity
        })

        animator.startAnimation(afterDelay: 1)
    }
    
    
    func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    
    func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                self.loginButton.transform = CGAffineTransform(translationX: 0,
                                                              y: 150)
            })
            
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            
            interactiveAnimator.addAnimations {
                self.loginButton.transform = .identity
            }
            
            interactiveAnimator.startAnimation()
        default: return
        }
    }

}

