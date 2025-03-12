//
//  ViewController.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

import UIKit

//MARK: ViewProtocol
protocol HomeViewProtocol: AnyObject {
    func displayResult(result: String)
}


//MARK: View
final class HomeViewController: UIViewController {

    // Dependency
    var interactor: HomeInteractorProtocol
    var router: HomeRouterProtocol
    
    // UI Elements
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .right
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()

    private let numberPadStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    //Properties
    private let labels: [[String]] = [
        ["⌫", "(", ")", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "－"],
        ["1", "2", "3", "+"],
        ["AC", "0", ",", "="]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    
    //init
    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //UIFunctions
    func setUpViews() {
        self.view.backgroundColor = .black
        
        setNumberPad()
        
        view.addSubview(label)
        view.addSubview(numberPadStackView)
        
        setConstraints()
    }
    
    func setNumberPad() {
        for row in labels {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 8
            
            for label in row {
                let button = UIButton(type: .system)
                button.setTitle(label, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = setBackgroundColorToEachButton(label: label)
                button.layer.cornerRadius = 30
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            numberPadStackView.addArrangedSubview(rowStackView)
        }
    }
    
    func setConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        numberPadStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberPadStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberPadStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberPadStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            numberPadStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: numberPadStackView.topAnchor, constant: -5),
            label.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12)
        ])
    }
    
    func setBackgroundColorToEachButton(label: String) -> UIColor {
        var color = UIColor.darkGray
        switch label {
        case "AC", "(", ")","⌫":
            color = .lightGray
        case "÷", "×", "－","+","=":
            color = .orange
        default: break
        }
        return color
    }
    
    

    //obj Functions
    @objc func buttonTapped(_ sender: UIButton) {
        guard
            let buttonTitle = sender.titleLabel?.text,
            let labelTitle = label.text
        else {return}
        print("Inside View")
        interactor.processResult(label: labelTitle, labelBtn: buttonTitle)
    }
    
}



//MARK: ExtensionView
extension HomeViewController: HomeViewProtocol {
    
    func displayResult(result: String) {
        
        label.text = result
    }
    
}
