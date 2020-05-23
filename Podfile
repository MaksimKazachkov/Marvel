workspace 'Marvel'

inhibit_all_warnings!
use_frameworks!

platform :ios, '13.2'

def swinject
  pod 'Swinject'
end

target 'Marvel' do
    project 'MarvelApp/Marvel/Marvel'
    swinject
    
    target 'MarvelTests' do
      inherit! :search_paths
    end
    
    target 'MarvelUITests' do
      inherit! :search_paths
    end

end

target 'MarvelUseCase' do
    project 'MarvelApp/MarvelUseCase/MarvelUseCase'
    swinject
    
    target 'MarvelUseCaseTests' do
      inherit! :search_paths
    end

end

target 'Core' do
    project 'MarvelApp/Core/Core'
    swinject
    
    target 'CoreTests' do
      inherit! :search_paths
    end

end

target 'MarvelCoreDataRepository' do
    project 'MarvelApp/MarvelCoreDataRepository/MarvelCoreDataRepository'
    
    target 'MarvelCoreDataRepositoryTests' do
      inherit! :search_paths
    end

end

target 'MarvelNetworkRepository' do
    project 'MarvelApp/MarvelNetworkRepository/MarvelNetworkRepository'
    
    target 'MarvelNetworkRepositoryTests' do
      inherit! :search_paths
    end

end

target 'MarvelNetwork' do
    project 'MarvelApp/MarvelNetwork/MarvelNetwork'
    
    target 'MarvelNetworkTests' do
      inherit! :search_paths
    end

end

target 'MarvelDomain' do
    project 'MarvelApp/MarvelDomain/MarvelDomain'
    
    target 'MarvelDomainTests' do
      inherit! :search_paths
    end

end
