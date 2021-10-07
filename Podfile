# Uncomment the next line to define a global platform for your project
abstract_target 'Laptop' do
  platform :macos, '11.0'

  pod 'GBDeviceInfo'
  pod 'SwiftyBeaver'
  pod 'SwiftySound'

  target 'Typyst (macOS)' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    # Pods for Typyst (macOS)
    # pod 'HotKey'
    pod 'Realm'
    pod 'RealmSwift', '~>10'
  end
end

abstract_target 'Mobile' do
  platform :ios, '14.0'

  pod 'GBDeviceInfo'
  pod 'SwiftyBeaver'
  pod 'SwiftySound'

  target 'Typyst (iOS)' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for Typyst (iOS)
    pod 'Realm'
    pod 'RealmSwift', '~>10'
  end

  target 'TypystKeyboard' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for Typyst (iOS)
    pod 'Realm'
    pod 'RealmSwift', '~>10'
  end
end
