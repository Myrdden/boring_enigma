require './lib/enigma.rb'
class Decoder
  def Enigma.decrypt(msg, keyInp, date = Enigma.get_date)
    date ||= Enigma.get_date
    a, b, c, d = Enigma.parse(keyInp, date)
    a = Enigma.generate(a); b = Enigma.generate(b)
    c = Enigma.generate(c); d = Enigma.generate(d)
    msg = msg.downcase
    origin = ('a'..'z').to_a.push(' ')
    decrypt = ""
    count = 0
    msg.each_char do |char|
      if char.match?(/[^a-z ]/)
          decrypt << char
      else
        count += 1; count = 0 if count > 3
        case count
        when 0; s = a.index(char); when 1; s = b.index(char)
        when 2; s = c.index(char); when 3; s = d.index(char)
        end
        at = origin[s]
        decrypt << at
      end
    end
    return {decrypted: decrypt, key: keyInp, date: date}
  end
end