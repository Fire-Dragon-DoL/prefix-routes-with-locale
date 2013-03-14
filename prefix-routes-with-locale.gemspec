$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "prefix-routes-with-locale/version"

Gem::Specification.new do |s|
  s.name = "prefix-routes-with-locale"
  s.version = PrefixRoutesWithLocale::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francesco Belladonna"]
  s.date = "2013-03-14"
  s.description = "Simple gem to easily support locale url prefix in Rails 3.x"
  s.email = []
  s.homepage = "https://github.com/Fire-Dragon-DoL/prefix-routes-with-locale"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/FireDragonDoL/prefix-routes-with-locale"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Simple gem to easily support locale url prefix in Rails 3.x"

  s.add_dependency('http_accept_language')
end