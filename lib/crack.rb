require './lib/enigma'
require './lib/levenshtein'

class Enigma
  def self.crack(msg, date = self.get_date, keyLength = 4)
    groups = Array.new(keyLength, [])
    keyLength -= 1
    count = 0
    msg.each_char do |char|
      groups[count] << char
      count += 1; count = 0 if count > keyLength
    end
    groups.each do |str|

    end
  end

  def self.analyse(str)
    scores = {}
    (0..108).each do |i|
      scores[i] = self.frequency(self.get_plain(str, i))
    end
  end

  def self.get_plain(str, offset)
    abc = ('a'..'z').to_a << ' '
    out = ""
    str.each_char do |char|
      at = abc.index(char) - (offset % 27)
      at -= 1 if at < 0
      out << abc[at]
    end
    return out
  end

  def self.frequency(str)
    str.each
  end
end