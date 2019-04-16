require './lib/enigma'

if ARGV[0]
  input = File.open(ARGV[0], 'r')
  if ARGV[1]
    output = File.open(ARGV[1], 'w')
    key = ARGV[2]; date = ARGV[3]
    encrypted = Enigma.encrypt(input.read, key, date)
    output.write("#{encrypted[:key]}\n#{encrypted[:date]}\n#{encrypted[:encrypted]}")
    puts "Wrote to file #{output.path} with key #{encrypted[:key]} and date #{encrypted[:date]}"
    input.close; output.close
  else
    puts "Invalid output path"
  end
else
  puts "Invalid input path"
end