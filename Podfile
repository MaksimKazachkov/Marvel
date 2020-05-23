workspace 'Marvel'

inhibit_all_warnings!
use_frameworks!

def swinject
  pod 'Swinject'
end

target 'Marvel' do
    platform :ios, '13.2'
    swinject
    project 'MarvelApp/Marvel/Marvel'
end

target 'MarvelUseCase' do
    platform :ios, '13.2'
    project 'MarvelApp/MarvelUseCase/MarvelUseCase'
    swinject
    inherit! :search_paths

    target 'MarvelUseCaseTests' do
      swinject
    end

end

target 'Core' do
    platform :ios, '13.2'
    project 'MarvelApp/Core/Core'

    swinject

end
