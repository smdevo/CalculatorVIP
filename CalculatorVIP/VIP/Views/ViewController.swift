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
        label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
        label.minimumScaleFactor = 0.6
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let scrollViewForLabel: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        return scrollView
    }()

    private let numberPadStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    //Properties
    private let buttons: [[String]] = [
        ["⌫", "(", ")", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "－"],
        ["1", "2", "3", "+"],
        ["AC", "0", ".", "="]
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
    
    
    // MARK: - UIFunctions
    
    private func setUpViews() {
        self.view.backgroundColor = .black
        
        setNumberPadStackView()
        
        view.addSubview(scrollViewForLabel)
        scrollViewForLabel.addSubview(label)
        view.addSubview(numberPadStackView)
        
        setConstraints()
    }
    
    private func setNumberPadStackView() {
        for row in buttons {
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
    
    private func setConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        scrollViewForLabel.translatesAutoresizingMaskIntoConstraints = false
        numberPadStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberPadStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberPadStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberPadStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            numberPadStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            
            scrollViewForLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollViewForLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollViewForLabel.bottomAnchor.constraint(equalTo: numberPadStackView.topAnchor, constant: -5),
            scrollViewForLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 12),
            
            label.trailingAnchor.constraint(equalTo: scrollViewForLabel.trailingAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: scrollViewForLabel.leadingAnchor),
            label.widthAnchor.constraint(greaterThanOrEqualTo: scrollViewForLabel.widthAnchor),
            label.bottomAnchor.constraint(equalTo: scrollViewForLabel.bottomAnchor),
            label.topAnchor.constraint(equalTo: scrollViewForLabel.topAnchor)
        ])
        
    }
    
    private func setBackgroundColorToEachButton(label: String) -> UIColor {
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
    
    private func updateLabelSize() {
        let textSize = label.intrinsicContentSize
        let maxWidth = max(textSize.width, scrollViewForLabel.frame.width)

        label.frame.size.width = maxWidth
        scrollViewForLabel.contentSize = CGSize(width: maxWidth, height: scrollViewForLabel.frame.height)

        // Scroll to the rightmost part (show latest input)
        let offsetX = max(scrollViewForLabel.contentSize.width - scrollViewForLabel.frame.width, 0)
        scrollViewForLabel.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }

    //obj Functions
    @objc func buttonTapped(_ sender: UIButton) {
        guard
            let buttonTitle = sender.titleLabel?.text,
            let labelTitle = label.text
        else {return}
       // print("Inside View")
        interactor.processResult(label: labelTitle, labelBtn: buttonTitle)
    }
    
}



//MARK: ExtensionView
extension HomeViewController: HomeViewProtocol {
    
    func displayResult(result: String) {
        label.text = result
        updateLabelSize()
    }
    
}
