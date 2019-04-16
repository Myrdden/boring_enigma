require 'time'

class Enigma
  def initialize

  end

  def randKey; return rand(100000) end

  def getDate; return Time.now.strftime("%d%m%y") end

  def encrypt(msg, key = randKey, date = getDate)
    
  end

  def decrypt(msg, key, date = getDate)

  end
end