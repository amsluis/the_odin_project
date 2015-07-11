puts "Please enter text: "
text = gets.chomp.to_s
puts "Please enter cipher index: "
index = gets.chomp.to_i

answer = []
text.split.each do |word|
  output = []
  word.split('').each do |letter|
    if 65 <= letter.ord and letter.ord <= 90
      output << (((letter.ord + index - 65) % 25) + 65).chr
    elsif 97 <= letter.ord and letter.ord <= 122
      output << (((letter.ord + index - 97) % 25) + 97).chr
    end
  end
  answer << output.join('')
end
puts answer.join(' ')
