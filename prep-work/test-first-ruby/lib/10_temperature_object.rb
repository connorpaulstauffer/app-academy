class Temperature

  def initialize temp = {}
    @celcius_temp = temp[:c] if !temp[:c].nil?
    @farenheit_temp = temp[:f] if !temp[:f].nil?
  end

  def self.from_celsius cel
    Temperature.new(c: cel)
  end

  def self.from_fahrenheit far
    Temperature.new(f: far)
  end

  def self.ftoc far
    (far - 32) * (5.0 / 9)
  end

  def self.ctof cel
    cel * (9.0 / 5) + 32
  end

  def in_celsius
    @celcius_temp || Temperature.ftoc(@farenheit_temp)
  end

  def in_fahrenheit
    @farenheit_temp || Temperature.ctof(@celcius_temp)
  end

end


class Celsius < Temperature

  def initialize temp
    @celcius_temp = temp
  end

end


class Fahrenheit < Temperature

  def initialize temp
    @farenheit_temp = temp
  end

end
