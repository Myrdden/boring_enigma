require 'time'

class Enigma
  def self.rand_key; return rand(100000).to_s end

  def self.get_date; return Time.now.strftime("%d%m%y") end

  def self.parse(key, date)
    offsets = (date.to_i**2).to_s[-4..-1].chars.map {|x| x.to_i}
    a = key[0..1].to_i + offsets[0]
    b = key[1..2].to_i + offsets[1]
    c = key[3..4].to_i + offsets[2]
    d = key[4..5].to_i + offsets[3]
    return a, b, c, d
  end

  def self.generate(offset); return ('a'..'z').to_a.push(' ').rotate(offset) end

  def self.encrypt(msg, keyInp = self.rand_key, date = self.get_date)
    keyInp ||= self.rand_key; date ||= self.get_date
    a, b, c, d = self.parse(keyInp, date)
    a = self.generate(a); b = self.generate(b)
    c = self.generate(c); d = self.generate(d)
    origin = ('a'..'z').to_a.push(' ')
    encrypt = ""
    count = 0
    msg.each_char do |char|
      count += 1; count = 0 if count > 3
      s = origin.index(char)
      case count
      when 0; at = a[s]; when 1; at = b[s]
      when 2; at = c[s]; when 3; at = d[s]
      end
      encrypt << at
    end
    return {encrypted: encrypt, key: keyInp, date: date}
  end

  def self.decrypt(msg, keyInp, date = self.get_date)
    date ||= self.get_date
    a, b, c, d = self.parse(keyInp, date)
    a = self.generate(a); b = self.generate(b)
    c = self.generate(c); d = self.generate(d)
    origin = ('a'..'z').to_a.push(' ')
    decrypt = ""
    count = 0
    msg.each_char do |char|
      count += 1; count = 0 if count > 3
      case count
      when 0; s = a.index(char); when 1; s = b.index(char)
      when 2; s = c.index(char); when 3; s = d.index(char)
      end
      at = origin[s]
      decrypt << at
    end
    return {decrypted: decrypt, key: keyInp, date: date}
  end
end