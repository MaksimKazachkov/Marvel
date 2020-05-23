workspace 'Marvel'

inhibit_all_warnings!

def swinject
  pod 'Swinject'
end

target 'Marvel' do
    use_frameworks!
    platform :ios, '13.2'
    swinject
    project 'MarvelApp/Marvel/Marvel'
end

target 'MarvelUseCase' do
    use_frameworks!
    platform :ios, '13.2'
    project 'MarvelApp/MarvelUseCase/MarvelUseCase'
    swinject

    target 'MarvelUseCaseTests' do
      inherit! :search_paths
    end

end

target 'Core' do
    use_frameworks!
    platform :ios, '13.2'
    project 'MarvelApp/Core/Core'

    swinject

end
