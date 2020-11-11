# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

#Getting rid of warning "The iOS Simulator deployment target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to 14.0.99."
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('8.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end

target 'ZillowTracker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'

  target 'ZillowTrackerTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'ZTNorificationContent' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZTNorificationContent

end

target 'ZTNotificationService' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZTNotificationService

end
