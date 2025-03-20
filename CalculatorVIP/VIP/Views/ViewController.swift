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
    func displayResult(result: String)
    func setNumberPadStackView(from structure: [[String]], isRemoveAllEmentsFromStack: Bool)
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
        view.backgroundColor = .black
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
            l: .spacing(.x4),
            r:  -.spacing(.x4),
            b: -.spacing(.x4),
            h: UIScreen.main.bounds.height / 2)
        
        scrollViewForLabel.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            l: .spacing(.x4),
            r: -.spacing(.x4),
            h: UIScreen.main.bounds.height / .spacing(.x3))
        
        scrollViewForLabel.setConstraints(
            helperView: numberPadStackView,
            bToT: -.spacing(.x1))
        
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
            let labelTitle = label.text
        else { return }
        interactor.processResult(label: labelTitle, labelBtn: buttonTitle)
    }
}

//MARK: ExtensionView
extension HomeViewController: HomeViewProtocol {
    
    func displayResult(result: String) {
        label.text = result
        updateLabelSize()
    }
    
    func setNumberPadStackView(from structure: [[String]], isRemoveAllEmentsFromStack: Bool) {
        
        if isRemoveAllEmentsFromStack {
            resetView()
        }
        for row in structure {
            let rowStackView = StackView(axis: .horizontal, spacing: .spacing(.x2))
            
            for label in row {
                let button = CalculatorButton(title: label)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            numberPadStackView.addArrangedSubview(rowStackView)
        }
    }
}
