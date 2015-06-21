# def wonky_coins(n)
#   return 1 if n == 0
#   return wonky_coins(n / 2) + wonky_coins(n / 3) + wonky_coins(n / 4)
# end

def wonky_coins(coin)
  return 1 if coin == 0
  wonky_coins(coin / 2) + wonky_coins(coin / 3) + wonky_coins(coin / 4)
end
