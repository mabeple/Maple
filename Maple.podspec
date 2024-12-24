Pod::Spec.new do |s|
  s.name = 'Maple'
  s.version = '1.3.5'
  s.summary = 'Native Swift extensions'
  s.description = <<-DESC
  native Swift extensions.
                   DESC

  s.homepage = 'https://github.com/Mabeple/Maple'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'Mabeple' => 'cymapu@gmail.com' }
 
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'

  s.swift_version = '5.0'
  s.requires_arc = true
  s.source = { git: 'https://github.com/Mabeple/Maple.git', tag: s.version.to_s }
  s.default_subspecs = 'Core'
  
  s.subspec "Core" do |sp|
      sp.source_files = 'Sources/Maple/General/*.swift'
      sp.dependency 'Maple/Protocol'
      sp.dependency 'Maple/Shared'
      sp.dependency 'Maple/Foundation'
      sp.dependency 'Maple/UIKit'
      sp.dependency 'Maple/SwiftStdlib'
      sp.dependency 'Maple/CoreGraphics'
  end
  
  # Protocol
  s.subspec 'Protocol' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/Protocol/*.swift'
  end
  
  # Shared
  s.subspec 'Shared' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/Shared/*.swift'
  end
  
  # Foundation Extensions
  s.subspec 'Foundation' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/Foundation/*.swift'
  end
  
  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/UIKit/*.swift'
  end
  
  # AppKit Extensions
  s.subspec 'AppKit' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/AppKit/*.swift'
  end
  
  # SwiftStdlib Extensions
  s.subspec 'SwiftStdlib' do |sp|
    sp.source_files  = 'Sources/Maple/SwiftStdlib/*.swift'
  end
  
  # CoreGraphics Extensions
  s.subspec 'CoreGraphics' do |sp|
    sp.source_files  = 'Sources/Maple/General/*.swift', 'Sources/Maple/CoreGraphics/*.swift'
  end
end
