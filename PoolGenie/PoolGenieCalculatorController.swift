//
//  PoolGenieCalculatorController.swift
//  PoolGenie
//
//  Created by Ravil on 21.03.2024.
//

import UIKit
import SnapKit

final class PoolGenieCalculatorController: UIViewController {
    
    private var textFields = [UITextField]()
    let fields = ["Pool length", "Pool width", "Pool height", "Chlorine concentration", "Water pollution coefficient", "Days between cleanups"]

    let scrollView = UIScrollView()
    let containerView = UIView()
    private let pool_genie_calculate = UIButton(type: .custom)
    private let pool_genie_card_result = UIView()
    private let pool_genie_label_result = UILabel()
    
    private let pollutionTypePickerLabel = UILabel()
    private let pollutionTypePicker = UIPickerView()
    private let pollutionTypes = ["Biological", "Chemical", "Physical"]
    private var selectedPollutionType: Double = 0.97

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "pool_genie_bg")
        pool_genie_ui()
        pool_genie_bar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pool_genie_card_result.layer.cornerRadius = 12
    }
}

extension PoolGenieCalculatorController: PoolGenieUI {
    func pool_genie_ui() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        var lastElement: UIView?
        
        for field in fields {
            let label = UILabel()
            label.text = field
            label.font = UIFont(name: "Nunito-SemiBold", size: 13)
            label.textColor = UIColor(named: "pool_genie_yellow")
            containerView.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(lastElement?.snp.bottom ?? scrollView.snp.top).offset(20)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
            }
            
            let textField = createTextField()
            textFields.append(textField)
            containerView.addSubview(textField)
            
            textField.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(8)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(48)
            }
            
            lastElement = textField
        }
        
        pollutionTypePickerLabel.text = "Type of pollution"
        pollutionTypePickerLabel.textColor = UIColor(named: "pool_genie_yellow")
        pollutionTypePickerLabel.font = UIFont(name: "Nunito-Semibold", size: 13)
        pollutionTypePickerLabel.textAlignment = .left
        containerView.addSubview(pollutionTypePickerLabel)
        
        pollutionTypePickerLabel.snp.makeConstraints { make in
            make.top.equalTo(lastElement!.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        pollutionTypePicker.backgroundColor = .clear
        pollutionTypePicker.layer.borderColor = UIColor(named: "pool_genie_stroke")?.cgColor
        pollutionTypePicker.layer.borderWidth = 1
        pollutionTypePicker.delegate = self
        pollutionTypePicker.dataSource = self
        containerView.addSubview(pollutionTypePicker)
        
        pollutionTypePicker.snp.makeConstraints { make in
            make.top.equalTo(pollutionTypePickerLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        
        lastElement = pollutionTypePicker
        
        pool_genie_calculate.setImage(UIImage(named: "pool_genie_calculate"), for: .normal)
        pool_genie_calculate.addTarget(self, action: #selector(calculateChlorineAmount), for: .touchUpInside)
        containerView.addSubview(pool_genie_calculate)
        
        pool_genie_calculate.snp.makeConstraints { make in
            make.top.equalTo(pollutionTypePicker.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
        }
        
        pool_genie_card_result.backgroundColor = UIColor(named: "pool_genie_yellow")
        containerView.addSubview(pool_genie_card_result)
        
        pool_genie_card_result.snp.makeConstraints { make in
            make.top.equalTo(pool_genie_calculate.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.equalTo(63)
        }
        
        let boldFont = UIFont(name: "Nunito-Bold", size: 24)!
        let regularFont = UIFont(name: "Nunito-Regular", size: 14)!

        let attributedString = NSMutableAttributedString(string: "0 ", attributes: [.font: boldFont])
        attributedString.append(NSAttributedString(string: "g of chlorine", attributes: [.font: regularFont]))

        pool_genie_label_result.attributedText = attributedString
        pool_genie_label_result.textAlignment = .center
        pool_genie_label_result.textColor = .black
        containerView.addSubview(pool_genie_label_result)
        
        pool_genie_label_result.snp.makeConstraints { make in
            make.center.equalTo(pool_genie_card_result.snp.center)
        }
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "pool_genie_gray"),
            NSAttributedString.Key.font: UIFont(name: "Nunito-Medium", size: 16)
        ]
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.textColor = .white
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "Enter", attributes: attributes as [NSAttributedString.Key : Any])
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "pool_genie_stroke")?.cgColor
        return textField
    }
    
    func pool_genie_bar() {
        let imageView = UIImageView(image: UIImage(named: "pool_genie_logo"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "pool_genie_bg")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "pool_genie_menu"), style: .plain, target: self, action: #selector(pool_genie_button_tapped))
        navigationItem.rightBarButtonItem = menuButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func pool_genie_button_tapped() {
        
    }
    
    @objc private func calculateChlorineAmount() {
        // Проверяем, что все текстовые поля заполнены
        for (index, textField) in textFields.enumerated() {
            guard let text = textField.text, !text.isEmpty else {
                pool_genie_label_result.attributedText = NSAttributedString(string: "Please fill in the field: \(fields[index]).", attributes: [.foregroundColor: UIColor.red])
                return
            }
            guard Double(text.replacingOccurrences(of: ",", with: ".")) != nil else {
                pool_genie_label_result.attributedText = NSAttributedString(string: "Invalid number in field: \(fields[index]).", attributes: [.foregroundColor: UIColor.red])
                return
            }
        }
        
        // Теперь мы уверены, что все поля заполнены и значения можно преобразовать в Double
        guard let length = Double(textFields[0].text!.replacingOccurrences(of: ",", with: ".")),
              let width = Double(textFields[1].text!.replacingOccurrences(of: ",", with: ".")),
              let height = Double(textFields[2].text!.replacingOccurrences(of: ",", with: ".")),
              let concentration = Double(textFields[3].text!.replacingOccurrences(of: ",", with: ".")),
              let pollutionCoefficient = Double(textFields[4].text!.replacingOccurrences(of: ",", with: ".")),
              let daysBetween = Double(textFields[5].text!.replacingOccurrences(of: ",", with: ".")) else {
            pool_genie_label_result.attributedText = NSAttributedString(string: "Invalid input. Please check all fields.", attributes: [.foregroundColor: UIColor.red])
            return
        }
        
        let volume = length * width * height // Вычисляем объем воды в бассейне
        let Q = (concentration * volume) / (pollutionCoefficient * daysBetween) * 10000 * selectedPollutionType
        
        // Отображаем результат
        let boldFont = UIFont(name: "Nunito-Bold", size: 24)!
        let regularFont = UIFont(name: "Nunito-Regular", size: 14)!
        let formattedResult = NSMutableAttributedString(string: String(format: "%.2f ", Q), attributes: [.font: boldFont])
        formattedResult.append(NSAttributedString(string: "g of chlorine", attributes: [.font: regularFont]))
        
        pool_genie_label_result.attributedText = formattedResult
    }
}

extension PoolGenieCalculatorController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pollutionTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pollutionTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            selectedPollutionType = 0.97
        case 1:
            selectedPollutionType = 0.99
        default:
            selectedPollutionType = 0.98
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: pollutionTypes[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedString
    }
}
