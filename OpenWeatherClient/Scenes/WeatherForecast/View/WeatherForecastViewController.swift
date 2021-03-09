//
//  WeatherForecastViewController.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxKeyboard
import RxDataSources

final class WeatherForecastViewController: ViewController<WeatherForecastViewModel, EmptyViewInput> {

    typealias Section = SectionModel<String, WeatherForecastItem>
    typealias DataSource = RxTableViewSectionedReloadDataSource<Section>
    
    // MARK: - Constants
    
    private let searchBarHeight: CGFloat = 44.0
    private enum SectionType: Int {
        case weatherList = 0
        
        var header: String {
            switch self {
            case .weatherList: return ""
            }
        }
    }
    
    // MARK: - Properties
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: searchBarHeight))
        searchBar.backgroundColor = UIColor.background
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var spiner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundView = spiner
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        return tableView
    }()
    
    private lazy var dataSource: DataSource = {
        RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier())!
                cell.backgroundColor = UIColor.cell
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = item.text
                return cell
        })
    }()
    
    private lazy var searchBarInputTrigger = PublishRelay<String>()
    
    // MARK: - Override Methods
    
    override func setupViewDidLoad() {
        super.setupViewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        enableDimissKeyboardWhenTap()
        title = "Weather Forecast"
        
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindView() {
        super.bindView()
        RxKeyboard
            .instance
            .visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                self?.tableView.contentInset.bottom = keyboardVisibleHeight
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func setupViewModel() {
        searchBar
            .rx
            .text
            .orEmpty
            .changed
            .bind(to: searchBarInputTrigger)
            .disposed(by: rx.disposeBag)
        
        Observable.merge(searchBar.rx.cancelButtonClicked.asObservable(),
                         searchBar.rx.searchButtonClicked.asObservable())
            .subscribe(onNext: { [weak self] in self?.endEditing() })
            .disposed(by: rx.disposeBag)
        
        viewModel = WeatherForecastViewModel(inputs: WeatherForecastViewModelContract.Input(searchBarDidChanged: searchBarInputTrigger))
    }
    
    override func bindViewModel() {
        viewModel
            .outputs
            .isLoading
            .drive { [weak self] isLoading in
                if isLoading {
                    self?.spiner.startAnimating()
                } else {
                    self?.spiner.stopAnimating()
                }
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .outputs
            .weatherList
            .map{ [Section(model: "", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel
            .outputs
            .showErrorPopup
            .drive { [weak self] shouldShow in
                guard let self = self, shouldShow else { return }
                self.present(self.noConnectionAlert, animated: true, completion: nil)
            }
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension WeatherForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = SectionType(rawValue: section) else { return nil }
        switch sectionType {
        case .weatherList: return searchBar
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .weatherList: return searchBarHeight
        }
    }
}
