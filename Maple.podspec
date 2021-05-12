Pod::Spec.new do |s|
  s.name = 'Maple'
  s.version = '1.1.2'
  s.summary = 'Native Swift extensions'
  s.description = <<-DESC
  native Swift extensions.
                   DESC

  s.homepage = 'https://github.com/Mabeple/Maple'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'Mabeple' => 'cymapu@gmail.com' }
 
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.10'

  s.swift_version = '5.1'
  s.requires_arc = true
  s.source = { git: 'https://github.com/Mabeple/Maple.git', tag: s.version.to_s }
  s.source_files = ["Sources/Maple/**/*.swift", "Sources/Maple.h"]

end