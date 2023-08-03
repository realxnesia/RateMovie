# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

workspace 'RateMovie.xcworkspace'
project 'RateMovie.xcodeproj'

def rmcomponents_pod
  pod 'RMComponents',
      :path => 'RMPods/RMComponents',
      :testspecs => ['Tests']
end

def rmutilities_viewkit_pod
  pod 'RMUtilitiesViewKit',
  :path => 'RMPods/RMUtilitiesViewKit'
end

def rmdomain_entities_pod
  pod 'RMDomainEntities',
  :path => 'RMPods/RMDomainEntities'
end

def development_pods
  rmcomponents_pod
  rmutilities_viewkit_pod
  rmdomain_entities_pod
end

target 'RateMovie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Modular Pods
  development_pods
  
  # Pods for RateMovie
  pod 'Alamofire'
  pod 'netfox'
  pod 'IQKeyboardManager'
  pod 'Kingfisher'
  #pod 'TTGSnackbar'
  
end

target 'RateMovieTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'RateMovieUITests' do
  # Pods for testing
end

target 'RMComponents_Example' do
  use_frameworks!
  project 'RMPods/RMComponents/Example/RMComponents.xcodeproj'
  rmcomponents_pod
end

target 'RMUtilitiesViewKit_Example' do
  use_frameworks!
  project 'RMPods/RMUtilitiesViewKit/Example/RMUtilitiesViewKit.xcodeproj'
  rmutilities_viewkit_pod
end

target 'RMDomainEntities_Example' do
  use_frameworks!
  project 'RMPods/RMDomainEntities/Example/RMDomainEntities.xcodeproj'
  rmdomain_entities_pod
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
