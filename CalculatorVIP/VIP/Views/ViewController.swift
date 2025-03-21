//
//  ViewController.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//

//orientation
//Provider in RPNService

import UIKit

//MARK: ViewProtocol
protocol HomeViewProtocol: AnyObject {
    func displayResult(result: String, expression: String?)
    func setNumberPadStackView(from structure: [[CButton]], isRemoveAllEmentsFromStack: Bool)
}

//MARK: View
final class HomeViewController: UIViewController {
    
    // Dependency
    var interactor: HomeInteractorProtocol
    var router: HomeRouterProtocol
    
    // MARK: - UI Elements
    // CalculatorLabel
    private let label: UILabel = CustomLabel(text: "0")
    
    private let scrollViewForLabel: UIScrollView = CustomScrollView()
    
    private let numberPadStackView = StackView(spacing: .spacing(.x2))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = UIDevice.current.orientation.isLandscape
        interactor.didChangedOrientation(to: isLandscape ? .landscale : .portrait)
    }
    
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
        view.backgroundColor = UIColor.theme.backgroundColor
        view.addSubview(scrollViewForLabel)
        view.addSubview(numberPadStackView)
        scrollViewForLabel.addSubview(label)
        
        setConstraints()
        
        interactor.onViewDidLoad()
    }
    
    private func setConstraints() {
        
        numberPadStackView.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x4),
            right:  -.spacing(.x4),
            bottom: -.spacing(.x4),
            height: UIScreen.main.bounds.height / 2)
        
        scrollViewForLabel.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x4),
            right: -.spacing(.x4),
            height: UIScreen.main.bounds.height / .spacing(.x3))
        
        scrollViewForLabel.setConstraints(
            helperView: numberPadStackView,
            bottomToTop: -.spacing(.x1))
        
        label.setConstraints(
            helperView: scrollViewForLabel,
            hGTAnchor: true,
            wGTAnchor: true)
    }
    
    private func resetView() {
        numberPadStackView.removeAllArrangedSubviews()
        for subview in view.subviews {
            subview.removeConstraints(subview.constraints)
        }
        for subview in scrollViewForLabel.subviews {
            subview.removeConstraints(subview.constraints)
        }
        setConstraints()
    }
    
    private func updateLabelSize() {
        let textSize = label.intrinsicContentSize
        let maxWidth = max(textSize.width, scrollViewForLabel.frame.width)
        
        label.frame.size.width = maxWidth
        scrollViewForLabel.contentSize = CGSize(
            width: maxWidth,
            height: scrollViewForLabel.frame.height
        )
        // Scroll to the rightmost part (show latest input)
        let offsetMax = max(scrollViewForLabel.contentSize.width - scrollViewForLabel.frame.width, 0)
        let offset = CGPoint(x: offsetMax, y: 0)
        
        scrollViewForLabel.setContentOffset(offset, animated: false)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard
            let buttonTitle = sender.titleLabel?.text,
            let btn = CButton(rawValue: buttonTitle),
            let labelTitle = label.text
        else { return }
        
        
        
        interactor.processResult(label: labelTitle, labelBtn: btn)
    }
}

//MARK: ExtensionView
extension HomeViewController: HomeViewProtocol {
    
    func displayResult(result: String, expression: String?) {
        
        if let expression {
            
            print("Expression: \(expression)")
            
        }else {
            
            //not expression
            
        }
        
        label.text = result
        updateLabelSize()
    }
    
    func setNumberPadStackView(from structure: [[CButton]], isRemoveAllEmentsFromStack: Bool) {
        
        if isRemoveAllEmentsFromStack {
            resetView()
        }
        for row in structure {
            let rowStackView = StackView(axis: .horizontal, spacing: .spacing(.x2))
            
            for label in row {
                let button = CalculatorButton(button: label)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            numberPadStackView.addArrangedSubview(rowStackView)
        }
    }
}
