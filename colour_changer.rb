FILENAME = './public/stylesheet.css'.freeze

# https://coolors.co/119da4-0c7489-13505b-040404-d7d9ce

def process_input
  input = gets.chomp
  exit if input == 'exit'
  input.slice!('https://coolors.co/')
  input.split('-')
end

def correct?(array)
  result = true
  array.each { |x| result &&= (x.length == 6) }
  result
end

loop do
  puts 'Enter colours string:'
  color_array = process_input

  unless correct?(color_array)
    puts 'Invalid entry.'
    next
  end

  text = File.read(FILENAME)

  i = 0
  while i < 5
    color_text = "--color#{i}: ##{color_array[i]};"
    text = text.gsub(/--color#{i}:.+;/, color_text)
    i += 1
  end

  File.open(FILENAME, 'w') { |file| file.puts text }
end
