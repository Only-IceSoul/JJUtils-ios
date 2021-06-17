#
# Be sure to run `pod lib lint jjutils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'jjutils'
  s.version          = '1.4.5'
  s.summary          = 'utils for swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Class for create app faster
                       DESC

  s.homepage         = 'https://github.com/Only-IceSoul/JJUtils-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'only-icesoul' => 'justinjlf21@gmail.com' }
  s.source           = { :git => 'https://github.com/Only-IceSoul/JJUtils-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = ['src/**/*.{swift,h,m}']
  s.swift_version = '4.2'
  
  
  s.vendored_frameworks = 'src/Frameworks/*.framework'
  
  s.ios.preserve_paths = 'src/Frameworks'
  s.public_header_files = 'src/Frameworks/**/Headers/*.{h}'

# xcode 12 issue arm mac
  s.pod_target_xcconfig = { 'ARCHS'  => '$(ARCHS_STANDARD)' ,
 'ONLY_ACTIVE_ARCH' => 'YES'}
  s.user_target_xcconfig = { 'ARCHS'  => '$(ARCHS_STANDARD)', 'ONLY_ACTIVE_ARCH' => 'YES'}
  
#  s.ios.preserve_paths = 'src/Frameworks' , 'src/obj'
#  s.public_header_files = 'src/Frameworks/**/Headers/*.{h}' , 'src/obj/Headers/*.{h}'

  
  # s.resource_bundles = {
  #   'jjutils' => ['jjutils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'SkiaKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
