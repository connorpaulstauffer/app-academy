# def nearest_larger(arr, idx)
#   left = idx - 1
#   right = idx + 1
#   while left >= 0 || right < arr.length
#     if left >= 0 && arr[left] > arr[idx]
#       return left
#     elsif right < arr.length && arr[right] > arr[idx]
#       return right
#     end
#     left -= 1
#     right += 1
#   end
#   return nil
# end

def nearest_larger(arr, idx)
  diff = 1
  length = arr.length
  loop do
    left, right = idx - diff, idx + diff
    break if left < 0 && right >= length
    return left if arr[left] > arr[idx] && left >= 0
    return right if right < arr.length && arr[right] > arr[idx]
    diff += 1
  end
  nil
end
