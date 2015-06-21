
def super_print(string, options = {})
  default = { times: 1, upcase: false, reverse: false }
  options = default.merge(options)
  string = string.upcase if options[:upcase]
  string = string.reverse if options[:reverse]
  Array.new(options[:times], string).join(" ")
end
