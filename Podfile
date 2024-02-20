# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

target 'Messagers' do
  
  use_frameworks!

pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'


pod 'GoogleSignIn'
  
pod 'MessageKit' 
pod 'JGProgressHUD'
pod 'RealmSwift'
pod 'SDWebImage'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
               end
          end
   end
end
