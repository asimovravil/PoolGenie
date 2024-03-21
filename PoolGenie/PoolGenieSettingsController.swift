//
//  PoolGenieSettingsController.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit
import SnapKit
import StoreKit

final class PoolGenieSettingsController: UIViewController {

    let pool_genie_switch_bar = UISwitch()
    let pool_genie_noti = UIImageView()
    let pool_genie_share = UIButton()
    let pool_genie_rate = UIButton()
    let pool_genie_privacy = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "pool_genie_bg")
        pool_genie_ui()
        pool_genie_bar()
    }
}

extension PoolGenieSettingsController: PoolGenieUI {
    func pool_genie_ui() {
        pool_genie_switch_bar.isOn = UserDefaults.standard.bool(forKey: "Switch1State")
        pool_genie_switch_bar.onTintColor = .green
        pool_genie_switch_bar.addTarget(self, action: #selector(pool_genie_switch_bar_changed(_:)), for: .valueChanged)
        
        pool_genie_noti.image = UIImage(named: "pool_genie_noti")
        pool_genie_noti.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pool_genie_noti)
        view.addSubview(pool_genie_switch_bar)
        
        pool_genie_noti.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        pool_genie_switch_bar.snp.makeConstraints { make in
            make.trailing.equalTo(pool_genie_noti.snp.trailing).offset(-16)
            make.centerY.equalTo(pool_genie_noti.snp.centerY)
        }
        
        pool_genie_share.setImage(UIImage(named: "pool_genie_share"), for: .normal)
        pool_genie_share.addTarget(self, action: #selector(pool_genie_share_tapped), for: .touchUpInside)
        view.addSubview(pool_genie_share)
        
        pool_genie_share.snp.makeConstraints { make in
            make.top.equalTo(pool_genie_noti.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        pool_genie_rate.setImage(UIImage(named: "pool_genie_rate"), for: .normal)
        pool_genie_rate.addTarget(self, action: #selector(pool_genie_rate_tapped), for: .touchUpInside)
        view.addSubview(pool_genie_rate)
        
        pool_genie_rate.snp.makeConstraints { make in
            make.top.equalTo(pool_genie_share.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        pool_genie_privacy.setImage(UIImage(named: "pool_genie_privacy"), for: .normal)
        pool_genie_privacy.addTarget(self, action: #selector(pool_genie_privacy_privacy), for: .touchUpInside)
        view.addSubview(pool_genie_privacy)
        
        pool_genie_privacy.snp.makeConstraints { make in
            make.top.equalTo(pool_genie_rate.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    @objc private func pool_genie_switch_bar_changed(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "Switch1State")
    }
    
    func pool_genie_bar() {
        let leftLabel = UILabel()
        leftLabel.text = "Settings"
        leftLabel.textColor = .white
        leftLabel.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftLabel)
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "pool_genie_close"), style: .plain, target: self, action: #selector(pool_genie_button_tapped))
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func pool_genie_button_tapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func pool_genie_share_tapped() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func pool_genie_rate_tapped() {
        SKStoreReviewController.requestReview()
    }
    
    @objc func pool_genie_privacy_privacy() {
        let controller = PoolGeniePrivacyController()
        self.present(controller, animated: true)
    }
    
    @objc private func cardologyButton() {
        self.dismiss(animated: true)
    }
}
