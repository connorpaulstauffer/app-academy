require 'rubygems'
require 'RedCloth'
require 'hpricot'

r = RedCloth.new("this is a *test* of _using RedCloth_")
puts r.to_html
puts "success" if defined?(Hpricot)
