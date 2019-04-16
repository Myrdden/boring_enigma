require 'time'

class Enigma
  def self.randKey; return rand(100000) end

  def self.getDate; return Time.now.strftime("%d%m%y") end

  def self.parse(key, date)
    offsets = (date.to_i**2).to_s[-4..-1].chars.map {|x| x.to_i}
    a = key[0..1].to_i + offsets[0]
    b = key[1..2].to_i + offsets[1]
    c = key[3..4].to_i + offsets[2]
    d = key[4..5].to_i + offsets[3]
    return a, b, c, d
  end

  def self.generate(offset); return ('a'..'z').to_a.push(' ').rotate(offset) end

  def self.encrypt(msg, keyInp = self.randKey, date = self.getDate)
    a, b, c, d = self.parse(keyInp, date)
    a = self.generate(a); b = self.generate(b)
    c = self.generate(c); d = self.generate(d)
    origin = ('a'..'z').to_a.push(' ')
    encrypt = ""
    msg.each_char do |char|
      s = origin.index(char); at = a[s]
      s = a.index(at); at = b[s]
      s = b.index(at); at = c[s]
      s = c.index(at); at = d[s]
      encrypt << at
    end
    return {encrypted: encrypt, key: keyInp, date: date}
  end

  def decrypt(msg, keyInp, date = getDate)
    key = parse(keyInp, date)
  end
end