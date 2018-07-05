FILENAME = './public/stylesheet.css'.freeze

loop do
  puts 'Enter colours string:'
  color_array = process_input
  text = File.read(FILENAME)
  i = 0
  while i < 5
    color_text = "--color#{i + 1}: ##{color_array[i]};"
    text = text.gsub(/--color#{i + 1}:.+;/, color_text)
    i += 1
  end
  File.open(FILENAME, 'w') { |file| file.puts text }
end

def process_input
  input = gets.chomp
  exit if input == 'exit'
  input.slice!('https://coolors.co/')
  input.split('-')
end
