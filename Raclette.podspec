Pod::Spec.new do |s|
  s.name = 'Raclette'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.homepage = 'https://github.com/rmnblm/Raclette.git'
  s.summary = 'Simple UITableView manager written entirely in Swift 3'
  s.authors = { 'rmnblm' => 'rmnblm@gmail.com' }
  s.source = { :git => 'https://github.com/rmnblm/Raclette.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Raclette/*.swift'
end
