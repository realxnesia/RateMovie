# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RateMovie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for RateMovie
  pod 'Alamofire'
  pod 'netfox'
  pod 'IQKeyboardManager'
  pod 'Kingfisher'
  pod 'TTGSnackbar'
  
  target 'RateMovieTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'RateMovieUITests' do
    # Pods for testing
  end
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
