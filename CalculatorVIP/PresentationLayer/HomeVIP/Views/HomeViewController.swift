//
//  ViewController.swift
//  CalculatorVIP
//
//  Created by Samandar on 12/03/25.
//
//Samandar


import UIKit

//MARK: ViewProtocol
protocol HomeViewProtocol: AnyObject {
    func displayLabelResult(result: String)
    func displayNumberPadStackView(from structure: [[CButton]])
    func displayHistory(calculations: [Calculation])
}

//MARK: View
final class HomeViewController: UIViewController {
    
    // MARK: - Dependencies
    var interactor: HomeInteractorProtocol
    var router: HomeRouterProtocol
    
    
    // MARK: - Data
    private var calculations: [Calculation] = []

    
    
    var a: Bool = true
    
    // MARK: - UI Elements
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
        label.minimumScaleFactor = 0.6
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment  = .right
        label.textColor = UIColor.theme.labelCalcColor
        return label
    }()
   
    private let scrollViewForLabel: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let clearAllButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "trash", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.theme.operatorColor
        return button
    }()

    private let numberPadStackView: UIStackView = CustomStackView(spacing: .spacing(.x2))
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
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
        view.addSubview(clearAllButton)
        scrollViewForLabel.addSubview(label)
        
        clearAllButton.addTarget(self, action: #selector(clearAllHistory), for: .touchUpInside)
        
        setConstraints()
        setUpTableView()
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
        
        clearAllButton.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x4),
            top: .spacing(.x2))
        
        tableView.setConstraints(
            helperView: view,
            isFromSafeArea: true,
            left: .spacing(.x1),
            right: -(.spacing(.x1)),
            top: .spacing(.x1))
        
        tableView.setConstraints(
            helperView: scrollViewForLabel,
            bottomToTop: 0)
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
        
        if btn == .equal {
            interactor.calculateAndAddToHistory(label: labelTitle)
        }else {
            interactor.addButtonToLabel(label: labelTitle, labelBtn: btn)
        }
        
    }
    
    @objc func clearAllHistory() {
        
        let alert = UIAlertController(
            title: "Clear History",
            message: "Do you want to clear history?",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { [weak self] action in
                self?.interactor.clearHistory()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
}


//MARK: -Extension For Displaying
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
    
    func displayLabelResult(result: String) {
        label.text = result
        updateLabelSize()
    }
    
    func displayNumberPadStackView(from structure: [[CButton]]) {
        for row in structure {
            let rowStackView = CustomStackView(axis: .horizontal, spacing: .spacing(.x2))
            
            for label in row {
                let button = CalculatorButton(button: label)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            numberPadStackView.addArrangedSubview(rowStackView)
        }
    }
    
}


//MARK: -Extension For TableView

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell",
                                                 for: indexPath) as! CustomTableViewCell
        let calculation = calculations[indexPath.row]
        
        cell.configure(calculationStr: calculation.expression ?? "1+2=3",
                       date: (calculation.date ?? Date()).settedFormat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        interactor.delateCalculation(indexPath: indexPath.row, items: calculations)
    }
}
    
}




















