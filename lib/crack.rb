require './lib/enigma'
require './lib/levenshtein'

class Enigma
  ENGLISH_FREQS = [' ','e','t','a','o','i','n','s','r','h','l','d','c','u','m',
    'f','p','g','w','y','b','v','k','x','j','q','z'].freeze

  def self.crack(msg, date = self.get_date, keyLength = 4)
    groups = Array.new(keyLength, [])
    keyLength -= 1
    count = 0; i = 0
    output = Array.new(msg.length, nil)
    require 'pry'; binding.pry
    msg.each_char do |char|
      if char.match?(/[^a-z ]/)
          output[i] = char
      else
        groups[count] << char
        count += 1; count = 0 if count > keyLength
      end
      i += 1
    end
    groups.each do |str|
        self.analyse(str)
    end
  end

  def self.analyse(str)
    scores = {}
    (0..27).each do |i|
      scores[i] = self.frequency(self.get_plain(str, i))
    end
  end

  def self.get_plain(str, offset)
    abc = ('a'..'z').to_a << ' '
    out = []
    str.each_char do |char|
      at = abc.index(char) - (offset % 27)
      at -= 1 if at < 0
      out << abc[at]
    end
    return out
  end

  def self.frequency(str)
    freq_include = ENGLISH_FREQS.select {|x| str.any? {|y| y == x}}
    require 'pry';binding.pry
    puts freq_include.to_s
  end
end

test = File.open('out.txt', 'r')
Enigma.crack(test.read)
