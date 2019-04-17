require 'rspec'
require './lib/enigma'

describe "unit test" do
  before(:all) do

  end

  it "gets date" do
    expect(Enigma.get_date).to match(/\d{5}/)
  end

  it "can parse" do
    expect(Enigma.parse("12345", "123456")).to eq [15, 32, 37, 54]
  end

  it "can gen shifts" do
    expect(Enigma.)
  end
end