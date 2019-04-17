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
end
