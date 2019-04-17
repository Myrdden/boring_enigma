require './lib/enigma'

if ARGV[0]
  input = File.open(ARGV[0], 'r')
  if ARGV[1]
    output = File.open(ARGV[1], 'w')
    lines = IO.readlines(input)
    decrypted = Enigma.decrypt(lines[2..-1].join.chomp, lines[0].chomp, lines[1].chomp)
    output.write("#{decrypted[:key]}\n#{decrypted[:date]}\n#{decrypted[:decrypted]}")
    puts "Wrote to file #{output.path} with key #{decrypted[:key]} and date #{decrypted[:date]}"
    input.close; output.close
  else
    puts "Invalid output path"
  end
else
  puts "Invalid input path"
end
