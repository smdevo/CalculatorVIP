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
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()

    private let numberPadStackView = StackView(spacing: .spacing(.x2))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            interactor.didChangedOrientation(to: .landscale)
        } else {
            print("Portrait")
            interactor.didChangedOrientation(to: .portrait)
        }
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
        
        label.translatesAutoresizingMaskIntoConstraints = false
        scrollViewForLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberPadStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: .spacing(.x4)
            ),
            numberPadStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: .spacing(.x4).minusSpacing
            ),
            numberPadStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -.spacing(.x8)
            ),
            numberPadStackView.heightAnchor.constraint(
                equalToConstant: UIDevice.current.orientation.isLandscape ? 80 : UIScreen.main.bounds.height / 2
            ),
            
            scrollViewForLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: .spacing(.x4)
            ),
            scrollViewForLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: .spacing(.x8).minusSpacing
            ),
            scrollViewForLabel.bottomAnchor.constraint(
                equalTo: numberPadStackView.topAnchor, constant: .spacing(.x1).minusSpacing
            ),
            scrollViewForLabel.heightAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.height / .spacing(.x3)
            ),
            
            label.widthAnchor.constraint(greaterThanOrEqualTo: scrollViewForLabel.widthAnchor),
            label.bottomAnchor.constraint(equalTo: scrollViewForLabel.bottomAnchor),
            label.topAnchor.constraint(equalTo: scrollViewForLabel.topAnchor)
        ])
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
            numberPadStackView.removeAllArrangedSubviews()
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
