//
//  ViewController.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit
import SnapKit

protocol PoolGenieUI {
    func pool_genie_ui()
    func pool_genie_bar()
}

final class PoolGenieOnboController: UIViewController {
    
    private let pool_genie_onbo1 = UIImageView()
    private let pool_genie_next = UIButton(type: .custom)
    private var pool_genie_is_second = false
    private var pool_genie_is_third = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pool_genie_ui()
        pool_genie_bar()
    }
}

extension PoolGenieOnboController: PoolGenieUI {
    func pool_genie_ui() {
        pool_genie_onbo1.image = UIImage(named: "pool_genie_onbo1")
        pool_genie_onbo1.contentMode = .scaleAspectFill
        view.addSubview(pool_genie_onbo1)
        
        pool_genie_onbo1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pool_genie_next.setImage(UIImage(named: "pool_genie_next"), for: .normal)
        pool_genie_next.addTarget(self, action: #selector(pool_genie_next_tapped), for: .touchUpInside)
        view.addSubview(pool_genie_next)
        
        pool_genie_next.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.centerX.equalToSuperview()
        }
    }
    
    func pool_genie_bar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "pool_genie_skip"), style: .plain, target: self, action: #selector(pool_genie_skip_tapped))
        navigationItem.rightBarButtonItem = backButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func pool_genie_skip_tapped() {
//        let vc = AztecCreateController()
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func pool_genie_next_tapped() {
        if pool_genie_is_second {
            pool_genie_is_third = true
            
//            let vc = AztecCreateController()
//            let navigationController = UINavigationController(rootViewController: vc)
//            navigationController.modalPresentationStyle = .fullScreen
//            self.present(navigationController, animated: true, completion: nil)
            return
        }
        
        pool_genie_is_second.toggle()
        aztec_update_ui()
    }
    
    private func aztec_update_ui() {
        if pool_genie_is_third {
            return
        }
        
        if pool_genie_is_second {
            pool_genie_onbo1.image = UIImage(named: "pool_genie_onbo2")
        } else {
            pool_genie_onbo1.image = UIImage(named: "pool_genie_onbo1")
        }
    }
}

