# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!
workspace 'RateMovie'

def core_pods
  pod 'Kingfisher'
  pod 'SkeletonView'
  pod "TTGSnackbar"	
  pod 'netfox', :configurations => ['Debug', 'Release']
  pod 'Alamofire'
  #pod 'IQKeyboardManager' #iOS8 and later
end

target 'RateMovie' do
  project 'RateMovie.project'
  core_pods
end

target 'Router' do
  project 'Router/Router.project'
end 


