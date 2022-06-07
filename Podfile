# Podfile
use_frameworks!

platform :ios, '10.6'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxCocoa', '6.5.0'
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
    pod 'Mocker', '2.5.5'
    pod 'Alamofire', '5.6.1'
end

def quality_gate_pods 
    pod 'SwiftLint'
end

target 'MarvelHeroes' do
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod 'Alamofire', '5.6.1'
    pod 'Kingfisher', '6.3.1'
    quality_gate_pods
end

target 'MarvelHeroesTests' do
    testing_pods
end

target 'MarvelHeroesUITests' do 
    testing_pods
end