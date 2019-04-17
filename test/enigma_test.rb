require 'minitest/autorun'
require './lib/enigma'

class EnigmaTest < MiniTest::Test
  def test_an_encryption
    expect = {encrypted: "ibrbpxbesij", key: "12345", date: "160419"}
    assert_equal expect, Enigma.encrypt("hello world", "12345", "160419")
  end

  def test_a_decryption
    expect = {encrypted: "ibrbpxbesij", key: "12345", date: "160419"}
    assert_equal expect, Enigma.decrypt("hello world", "12345", "160419")
  end
end