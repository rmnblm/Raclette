Pod::Spec.new do |s|
  s.name = 'Raclette'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.homepage = 'https://github.com/rmnblm/Raclette.git'
  s.summary = '🧀 Let\'s get cheesy with Raclette, a UITableView extension to add rows and sections on-the-fly'
  s.authors = { 'rmnblm' => 'rmnblm@gmail.com' }
  s.source = { :git => 'https://github.com/rmnblm/Raclette.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Raclette/*.swift'
end
