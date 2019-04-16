require 'minitest/autorun'
require './lib/enigma'

class EnigmaTest < MiniTest::Test
  def test_an_encryption
    expect = {encrypted: "", key: "", date: ""}
    #assert_equal expect, Enigma.encrypt("hello world", "12345", "160419")
    assert_equal expect, Enigma.decrypt("nkrrufbuxrj", "12345", "160419")
  end
end