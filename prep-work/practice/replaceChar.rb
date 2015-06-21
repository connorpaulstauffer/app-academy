def CountingMinutesI(str = "12:30pm-12:00am")
  str = str.split('-')
  time = []
  for i in 0..(str.length - 1)
    if str[i].index("pm") != nill
      time[i] = str[i].slice!('pm')
      time[i] = time[i].split(':')
      time[i][0] += 12
    else
      time[i] = str[i].slice!('am')
      time[i] = time[i].split(':')
    end
  end
  return time
         
end