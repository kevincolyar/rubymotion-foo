# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'
require "awesome_print_motion"

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.identifier = 'com.foo.foo'
  app.name = 'Foo'

  app.frameworks += ['Carbon', 'AppKit', 'ApplicationServices', 'CoreGraphics', 'Quartz', 'ScriptingBridge']
  app.vendor_project('vendor/foo', :static)
end

Dir.glob("tasks/**/*.{rake,rb}").each do|item|
  load File.expand_path(item)
end

task 'run' => [:trust_app]
