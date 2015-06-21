# def bubble_sort(arr)
#   swapped = true
#   while swapped
#     swapped = false
#     0.upto(arr.length - 2) do |i|
#       if arr[i] > arr[i + 1]  
#         arr[i], arr[i + 1] = arr[i + 1], arr[i]
#         swapped = true
#       end
#     end
#   end
#   return arr
# end

def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    0.upto(array.length - 2) do |idx|
      if array[idx] > array[idx + 1]
        array[idx], array[idx + 1] = array[idx + 1], array[idx]
        sorted = false
      end
    end
  end
  array
end
