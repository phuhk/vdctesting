//
//  WeatherForecastViewModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Action

final class WeatherForecastViewModel: BaseViewModel<WeatherForecastViewModelContract.Input,
                                                    WeatherForecastViewModelContract.Output,
                                                    WeatherForecastInteractor> {
    
    // MARK: - Properties
    
    lazy var weatherList = BehaviorRelay<[WeatherForecastItem]>(value: [])
    lazy var showErrorPopupTrigger = PublishRelay<Bool>()
    
    lazy var getDailyForecast: Action<(String), WeatherForecastModel> = {
        Action<(String), WeatherForecastModel> { [unowned self] city in
            self.dependencies
                .getDailyForecast(city)
                .asObservable()
        }
    }()
    
    // MARK: - Initialization
    
    override init(inputs: Input, dependencies: Dependency = Dependencies.getInteractor()) {
        super.init(inputs: inputs, dependencies: dependencies)
        configureAction()
    }
    
    // MARK: - Override Methods
    
    override func transform() {
        dependencies
            .networkReachability
            .connected
            .map{ !$0 }
            .bind(to: showErrorPopupTrigger)
            .disposed(by: rx.disposeBag)
        
        setOutput(
            Output(
                isLoading: isLoading.asDriver(),
                weatherList: weatherList.asDriver(),
                showErrorPopup: showErrorPopupTrigger.asDriver(onErrorDriveWith: .never())
            )
        )
    }
    
    override func viewModelDidBind() {
        inputs
            .searchBarDidChanged
            .debounce(RxTimeInterval.milliseconds(Constants.timeoutMilliseconds),
                      scheduler: MainScheduler.instance)
            .filter({ !$0.isEmpty })
            .subscribe(onNext: { [weak self] city in
                self?.getDailyForecast.execute(city)
            })
            .disposed(by: rx.disposeBag)
        
        inputs
            .searchBarDidChanged
            .filter({ $0.isEmpty })
            .map({ _ in [WeatherForecastItem]() })
            .bind(to: weatherList)
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - Action
    
    private func configureAction() {
        getDailyForecast
            .elements
            .map{ $0.list.map({ WeatherForecastItem(from: $0) }) }
            .bind(to: weatherList)
            .disposed(by: rx.disposeBag)
        
        getDailyForecast
            .errors
            .map({ error -> ApiError in
                guard case .underlyingError(let error) = error,
                      let apiError = error as? ApiError else { return ApiError.unknown }
                return apiError
            })
            .do(onNext: { [weak self] in
                guard $0 == ApiError.unsuccessful else { return }
                self?.weatherList.accept([])
            })
            .map({ $0 == ApiError.network })
            .bind(to: showErrorPopupTrigger)
            .disposed(by: rx.disposeBag)
        
        getDailyForecast
            .executing
            .bind(to: isLoading)
            .disposed(by: rx.disposeBag)
    }
}
