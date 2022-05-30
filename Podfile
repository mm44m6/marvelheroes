# Podfile
use_frameworks!

platform :ios, '10.6'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
end

target 'MarvelHeroes' do
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
end

target 'MarvelHeroesTests' do
    testing_pods
end

target 'MarvelHeroesUITests' do 
    testing_pods
end