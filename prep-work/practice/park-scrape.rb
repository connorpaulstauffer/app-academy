require 'nokogiri'
require 'open-uri'
require 'csv'

name = Array.new
state = Array.new

doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_national_parks_of_the_United_States"))

name_xml = doc.css("tr th[scope='row']")
state_xml = doc.xpath("//tr/td[2]/a[1]")

name_xml.each{|head| name << head.text}
state_xml.each{|head| state << head.text}

puts name.zip(state)
