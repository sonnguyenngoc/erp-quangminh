$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "erp/quangminh/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "erp_quangminh"
  s.version     = Erp::Quangminh::VERSION
  s.authors     = ["Nguyễn Ngọc Sơn"]
  s.email       = ["sonnn0811@gmail.com"]
  s.homepage    = "http://noithatquangminh.vn/"
  s.summary     = "Website nội thất Quang Minh"
  s.description = "Website nội thất Quang Minh"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.1.6"
  s.add_dependency "erp_core"
  s.add_dependency "deface"
end
