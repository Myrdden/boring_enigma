require 'time'
require './lib/encrypter'
require './lib/decrypter'

class Enigma
  def self.rand_key; return rand(100000).to_s end

  def self.get_date; return Time.now.strftime("%d%m%y") end

  def self.parse(key, date)
    require 'pry';binding.pry
    offsets = (date.to_i**2).to_s[-4..-1].chars.map {|x| x.to_i}
    a = key[0..1].to_i + offsets[0]
    b = key[1..2].to_i + offsets[1]
    c = key[2..3].to_i + offsets[2]
    d = key[3..4].to_i + offsets[3]
    return a, b, c, d
  end

  def self.generate(offset); return ('a'..'z').to_a.push(' ').rotate(offset) end
  def self.encrypt(msg, key = self.rand_key, date = self.get_date)
    key ||= self.rand_key; date ||= self.get_date
    Encrypter.encrypt(msg, key, date)
  end
  def self.decrypt(msg, key, date = self.get_date)
    date ||= self.get_date
    Decrypter.decrypt(msg, key, date)
  end
end
