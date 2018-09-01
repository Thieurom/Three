//
//  HomeViewController.swift
//  Three
//
//  Created by Doan Le Thieu on 8/20/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Subviews
    
    lazy var playWithFriendButton: Button = {
        let button = Button()
        button.setTitle("Play with Friend", for: .normal)
        
        return button
    }()
    
    lazy var fightTheRobotButton: Button = {
        let button = Button(style: .secondary)
        button.setTitle("Fight the Robot", for: .normal)
        
        return button
    }()
    
    // MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        setUpSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private

extension HomeViewController {
    
    @objc private func playWithFriendButtonPressed(_ sender: UIButton) {
        let settingViewController = SettingViewController(isFightingRobot: false)
        
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc private func fightTheRobotButtonPressed(_ sender: UIButton) {
        let settingViewController = SettingViewController(isFightingRobot: true)
        
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    // Further config the root view since it will be created programmatically
    private func configView() {
        view.backgroundColor = .white
        
        // customize navigationBar for this and will-be-pushed view controllers
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        
        let backImage = UIImage(named: "back_bar_button")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        // remove the title of back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // Setup subviews
    private func setUpSubviews() {
        // add subviews to view hierarchy
        view.addSubview(playWithFriendButton)
        view.addSubview(fightTheRobotButton)
        
        // constraint subviews
        playWithFriendButton.translatesAutoresizingMaskIntoConstraints = false
        fightTheRobotButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playWithFriendButton.heightAnchor.constraint(equalToConstant: 44),
            playWithFriendButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            playWithFriendButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            playWithFriendButton.bottomAnchor.constraint(equalTo: fightTheRobotButton.topAnchor, constant: -8)])
        
        NSLayoutConstraint.activate([
            fightTheRobotButton.heightAnchor.constraint(equalToConstant: 44),
            fightTheRobotButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            fightTheRobotButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            fightTheRobotButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160)])
        
        // config action-target for button
        playWithFriendButton.addTarget(self, action: #selector(playWithFriendButtonPressed(_:)), for: .touchUpInside)
        
        fightTheRobotButton.addTarget(self, action: #selector(fightTheRobotButtonPressed(_:)), for: .touchUpInside)
    }
}
