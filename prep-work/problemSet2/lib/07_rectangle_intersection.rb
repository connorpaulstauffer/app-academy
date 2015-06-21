# def rec_intersection(rect1, rect2)
#   point1 = []
#   point2 = []
#   point1 << [rect1[0][0], rect2[0][0]].max
#   point2 << [rect1[1][0], rect2[1][0]].min
#   point1 << [rect1[0][1], rect2[0][1]].max
#   point2 << [rect1[1][1], rect2[1][1]].min
#   return nil if point1[0] > point2[0] || point1[1] > point2[1]
#   return [point1, point2]
# end

def rec_intersection(rect1, rect2)
  bot_x, bot_y = [rect1[0][0], rect2[0][0]].max, [rect1[0][1], rect2[0][1]].max
  top_x, top_y = [rect1[1][0], rect2[1][0]].min, [rect1[1][1], rect2[1][1]].min
  return nil if bot_x > top_x || bot_y > top_y
  [[bot_x, bot_y], [top_x, top_y]]
end
