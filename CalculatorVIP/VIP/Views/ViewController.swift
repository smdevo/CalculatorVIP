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
    func displayHistory(calculations: [Calculation])
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
    
    private let tableView = CustomTableView()
    
    
    
    private var calculations: [Calculation] = []
    
    
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
        view.addSubview(tableView)
        scrollViewForLabel.addSubview(label)
        
        setUpTableView()
        
        setConstraints()
        
        interactor.onViewDidLoad()
    }
    
    private func setUpTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setConstraints() {
        
        numberPadStackView.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x1),
            right:  -.spacing(.x1),
            bottom: -.spacing(.x1),
            height: (UIScreen.main.bounds.height) / 9 * 4)

        scrollViewForLabel.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x1),
            right: -.spacing(.x1),
            height: UIScreen.main.bounds.height / .spacing(.x3))
        
        scrollViewForLabel.setConstraints(
            helperView: numberPadStackView,
            bottomToTop: -.spacing(.x1))
        
        label.setConstraints(
            helperView: scrollViewForLabel,
            hGTAnchor: true,
            wGTAnchor: true)
        
        tableView.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x1),
            right: -(.spacing(.x1)),
            top: .spacing(.x1))
        
        tableView.setConstraints(
            helperView: scrollViewForLabel,
            bottomToTop: 0)
//
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

//MARK: Extension For Preview
extension HomeViewController: HomeViewProtocol {
    
    
    func displayHistory(calculations: [Calculation]) {
        
        self.calculations.removeAll()
        
        self.calculations = calculations
        
        tableView.reloadData()

        DispatchQueue.main.async {
            let lastIndex = IndexPath(row: self.calculations.count - 1, section: 0)
            if self.calculations.count > 0 {
                self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: false)
            }
        }


        
        tableView.reloadData()
    }
    
    
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


//MARK: Extension For TableView

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let calculation = calculations[indexPath.row]
        
        //print(calculation.expression ?? "1+1")
        
        cell.configure(calculationStr: calculation.expression ?? "1+2=3", date: (calculation.date ?? Date()).settedFormat)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteCalculation(indexPath: indexPath.row, items: calculations)
        }
    }
    
    
}




















