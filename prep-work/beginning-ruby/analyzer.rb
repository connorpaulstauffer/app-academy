lines = File.readlines(ARGV[0])
line_count = lines.length
text = lines.join
total_chars = text.length
total_chars_nospace = text.gsub(/\s+/, '').length
total_words = text.split.length
sentence_count = text.split(/\.|\?|!/).length
par_count = text.split(/\n\n/).length
words_per_sentence = (total_words.to_f / sentence_count).round(1)
sentences_per_paragraph = (sentence_count.to_f / par_count).round(1)
stop_words = %{the a by on for of are with just but and to the my I has some in}
words = text.scan(/\w+/)
keywords = words.select { |w| !stop_words.include?(w) }
prop = ((keywords.length.to_f / words.length ) * 100 ).to_i
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |s| s.length }
one_third = sentences.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |s| s =~ /is|are/ }

puts "#{line_count} lines"
puts "#{total_chars} characters"
puts "#{total_chars_nospace} characters without spaces"
puts "#{total_words} words"
puts "#{sentence_count} sentences"
puts "#{par_count} paragraphs"
puts "#{words_per_sentence} words per sentence"
puts "#{sentences_per_paragraph} sentences per paragraph"
puts "#{prop} percent non-stop words"
puts ideal_sentences.join(". ")