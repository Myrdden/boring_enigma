require './lib/enigma'
require './lib/levenshtein'

class Enigma
  ENGLISH_FREQS = [' ','e','t','a','o','i','n','s','r','h','l','d','c','u','m',
    'f','p','g','w','y','b','v','k','x','j','q','z'].freeze

  def self.crack(msg, date = self.get_date, keyLength = 4)
    groups = Array.new(keyLength) {[]}
    keyLength -= 1
    count = 0; i = 0
    base = Array.new(msg.length, nil)
    msg.each_char do |char|
      if char.match?(/[^a-z ]/)
          base[i] = char
      else
        groups[count] << char
        count += 1; count = 0 if count > keyLength
      end
      i += 1
    end
    keys = Array.new(keyLength)
    groups.each_with_index do |str, i|
      keys[i] = self.analyse(str)
    end
    wow = []
    tests = self.generate_perms(keys).sort {|a,b| a[1] <=> b[1]}.map {|k,v| k}
    tests.each do |test|
      key_set = []
      test.each_with_index {|k, i| key_set << keys[i][k.to_i]}
      key = self.generate_combs(key_set)
      yoop = self.guess_set(groups, key, base)
      wow = wow + yoop
      break if yoop.any? {|x| x == "hello world my name is greg"}
      #require 'pry'; binding.pry
    end
    puts wow.find_index("hello world my name is greg")
    #require 'pry'; binding.pry
  end

  def self.guess_set(groups, key, base)
    oof = {}
    key.each do |k|
      donk = self.sample(groups, k, base)
      puts donk
      oof[donk] =  self.frequency(donk.chars)
    end
    return oof.sort {|a,b| b[0] <=> a[0]}.map {|k,v| k}
  end

  def self.sample(groups, key, base)
    output = base.dup
    length = groups.count
    groups.each_with_index do |str, i|
      current = self.get_plain(str, key[i])
      output.each_index do |j|
        if j % length == i
          output[j] = current.shift
        end
      end
    end
    return output.join
  end

  def self.generate_combs(keys)
    x, *xs = keys
    if xs.empty?
      return x.map {|y| [y]}
    end
    out = []
    x.each do |i|
      subs = self.generate_combs(xs)
      subs.each {|sub| out << [i] + sub}
    end
    return out
  end

  def self.generate_perms(keys)
    x, *xs = keys
    inc = 0; out = {}
    if xs.empty?
      (0..(x.count - 1)).to_a.each do |i|
        out[[i]] = inc
        inc += 1
      end
    else
      (0..(x.count - 1)).to_a.each do |i|
        subs = self.generate_perms(xs)
        subs.keys.each do |sub|
          out[[i] + sub] = subs[sub] + inc
        end
        inc += 1
      end
    end
    return out
  end

  def self.analyse(str)
    scores = {}
    (0..27).each do |i|
      scores[i] = self.frequency(self.get_plain(str, i))
    end
    out = Hash.new {|h,k| h[k] = []}
    scores.each do |k,v|
      out[v] << k
    end
    return out.sort {|a,b| a[0] <=> b[0]}.map {|k,v| v}
  end

  def self.get_plain(str, offset)
    abc = ('a'..'z').to_a << ' '
    out = []
    str.each do |char|
      at = abc.index(char) - (offset % 27)
      at -= 1 if at < 0
      out << abc[at]
    end
    return out
  end

  def self.frequency(str)
    freq_include = ENGLISH_FREQS.select {|x| str.any? {|y| y == x}}
    sorted = str.sort {|a,b| str.count {|x| x == b} <=> str.count {|x| x == a}}
    sorted = sorted.uniq
    return self.distance(sorted, freq_include)
  end

  def self.distance(tests, freqs)
    total = 0
    tests.each_with_index do |x, i|
      target = freqs.index(x)
      diff = target - i
      total += diff.abs
    end
    return total
  end
end

test = File.open('out.txt', 'r')
Enigma.crack(test.read)
