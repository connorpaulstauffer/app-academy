def measure rep = 1
  start = Time.now
  rep.times { yield }
  (Time.now - start) / rep
end