require './lib/enigma'
class Encrypter
  def self.encrypt(msg, keyInp = Enigma.rand_key, date = Enigma.get_date)
    keyInp ||= Enigma.rand_key; date ||= Enigma.get_date
    a, b, c, d = Enigma.parse(keyInp, date)
    a = Enigma.generate(a); b = Enigma.generate(b)
    c = Enigma.generate(c); d = Enigma.generate(d)
    msg = msg.downcase
    origin = ('a'..'z').to_a.push(' ')
    encrypt = ""
    count = 0
    msg.each_char do |char|
      s = origin.index(char)
      if char.match?(/[^a-z ]/)
          encrypt << char
      else
        count += 1; count = 0 if count > 3
        case count
        when 0; at = a[s]; when 1; at = b[s]
        when 2; at = c[s]; when 3; at = d[s]
        end
        encrypt << at
      end
    end
    return {encrypted: encrypt, key: keyInp, date: date}
  end
end