class Timer

  attr_accessor :seconds

  def initialize seconds = 0
    @seconds = seconds
  end

  def time_string
    minutes = @seconds / 60
    seconds = @seconds % 60
    hours = minutes / 60
    minutes %= 60
    "#{padded hours}:#{padded minutes}:#{padded seconds}"
  end

  def padded int
    int < 10 ? "0#{int}" : int.to_s
  end

end
