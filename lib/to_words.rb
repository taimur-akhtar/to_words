module ToWords
  require 'to_words/version'
  require_relative './to_words/under_hundred.rb'
  require_relative './to_words/divisions.rb'

  include ToWords::UnderHundred
  include ToWords::Divisions

  def to_words
    num = numerical?(self)
    num, sign = check_sign(num)
    return (sign + UNDER_HUNDRED[num]) if num <= 100
    counter = 0
    result = []
    while num != 0
      num, remaining = num.divmod(1000)
      temp_result = result_below_one_thousand(remaining, counter)
      result << temp_result + ' ' + DIVISIONS[counter] + ' ' if temp_result != ''
      counter += 1
    end
    sign + result.reverse.join(', ').rstrip
  end

  def result_below_one_thousand(num, counter)
    hundred, remaining = num.divmod(100)
    return UNDER_HUNDRED[hundred] + ' Hundred ' + UNDER_HUNDRED[remaining]     if hundred != 0 && remaining != 0 && counter != 0
    return UNDER_HUNDRED[hundred] + ' Hundred and ' + UNDER_HUNDRED[remaining] if hundred != 0 && remaining != 0
    return UNDER_HUNDRED[remaining]                                            if hundred == 0 && remaining != 0
    return UNDER_HUNDRED[hundred] + ' Hundred '                                if hundred != 0 && remaining == 0
    ''
  end

  def check_sign(num)
    num < 0 ? [num.abs.to_i, 'negative '] : [num.to_i, '']
  end

  def numerical?(num)
    Float(num)
  rescue
    raise 'A number is expected'
  end
end

class Fixnum
  include ToWords
end

class String
  include ToWords
end
