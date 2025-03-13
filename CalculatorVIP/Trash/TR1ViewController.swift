//
//  TR1ViewController.swift
//  CalculatorVIP
//
//  Created by Samandar on 13/03/25.
//

import UIKit

class TR1ViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .lightGray
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.text = "0"
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Number", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add ScrollView
        view.addSubview(scrollView)
        scrollView.addSubview(numberLabel)
        
        // Add Button
        view.addSubview(addButton)
        
        // Constraints for ScrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Constraints for Number Label
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10), // Add some padding
            numberLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: 10),
            numberLabel.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor)
        ])
        
//        // Ensure the label's width is at least the width of the scrollView
//        numberLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        numberLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        // Constraints for Button
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add Button Action
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    // MARK: - Button Action
    @objc private func didTapAddButton() {
        // Append a random number (0-9) to the label
        let randomNumber = Int.random(in: 0...9)
        numberLabel.text?.append("\(randomNumber)")
        
        // Update the content size of the scrollView
        let labelSize = numberLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: scrollView.bounds.height))
        scrollView.contentSize = CGSize(width: labelSize.width + 20, height: scrollView.bounds.height) // Add padding
        
        // Scroll to the end of the label
        let offsetX = max(0, labelSize.width - scrollView.bounds.width + 20) // Add padding
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
