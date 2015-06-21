
class Array

  def sum
    inject(0, :+)
  end

  def square
    map { |el| el ** 2 }
  end

  def square!
    map! { |el| el ** 2 }
  end

end
