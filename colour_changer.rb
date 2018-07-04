FILENAME = './public/stylesheet.css'.freeze

loop do
  puts 'Enter colours string:'
  input = gets.chomp
  exit if input == 'exit'
  input.slice!('https://coolors.co/')
  color_array = input.split('-')
  text = File.read(FILENAME)
  i = 0
  while i < 10
    color_text = "--color#{i + 1}: ##{color_array[i]};"
    text = text.gsub(/--color#{i + 1}:.+;/, color_text)
    i += 1
  end
  File.open(FILENAME, 'w') { |file| file.puts text }
end
