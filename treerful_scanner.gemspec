# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'treerful_scanner'
  spec.version = '1.1.6'
  spec.author = 'Jian Weihang'
  spec.email = 'tonytonyjan@gmail.com'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/tonytonyjan/treerful_scanner'
  spec.summary = '小樹屋掃描器 - 找出特定日期所有小樹屋的時間表'
  spec.files = Dir['lib/**/*.{rb,erb}']
  spec.executables << 'treerful_scanner'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'em-http-request'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
end
