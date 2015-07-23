require "to_words/version"

module ToWords

  UNDER_HUNDRED =
    {""=>"",
     0=>"nol",
     1=>"satu",
     2=>"dua",
     3=>"tiga",
     4=>"empat",
     5=>"lima",
     6=>"enam",
     7=>"tujuh",
     8=>"delapan",
     9=>"sembilan",
     10=>"sepuluh",
     11=>"sebelas",
     12=>"dua belas",
     13=>"tiga belas",
     14=>"empat belas",
     15=>"lima belas",
     16=>"enam belas",
     17=>"tujuh belas",
     18=>"delapan belas",
     19=>"sembilan belas",
     20=>"dua puluh",
     30=>"tiga puluh",
     40=>"empat puluh",
     50=>"lima puluh",
     60=>"enam puluh",
     70=>"tujuh puluh",
     80=>"delapan puluh",
     90=>"sembilan puluh",
     100=>"seratus",
     1000=>"seribu"}

  DIVISIONS = ["", "ribu", "juta", "miliar", "triliun"]

  def to_words
    num = self.to_i
    num, sign = check_sign(num)
    return (sign + UNDER_HUNDRED[num]) if num == 1000
    return (sign + under_hundred(num)) if num <= 100
    counter = 0
    result = []
    while num != 0
      num, remaining = num.divmod(1000)
      temp_result = result_below_one_thousand(remaining, counter)
      result << temp_result + " " + DIVISIONS[counter] + " " if temp_result != ''
      counter += 1
    end
    return sign + result.reverse.join("").rstrip
  end

  def result_below_one_thousand(num, counter)
    hundred, remaining = num.divmod(100)
    hundred_in_word = " "
    hundred_in_word = " ratus " if hundred > 1
    hundred = hundred * 100 if hundred == 1

    return under_hundred(hundred) + hundred_in_word + under_hundred(remaining)     if hundred != 0 && remaining != 0 && counter != 0
    # return UNDER_HUNDRED[hundred] + " Hundred and " + UNDER_HUNDRED[remaining] if hundred != 0 && remaining != 0
    return under_hundred(hundred) + hundred_in_word + under_hundred(remaining)     if hundred != 0 && remaining != 0
    return under_hundred(remaining)                                                if hundred == 0 && remaining != 0
    return under_hundred(hundred) + hundred_in_word                                if hundred != 0 && remaining == 0
    return ''
  end

  def under_hundred(num)
    return UNDER_HUNDRED[num] if num < 20
    num, remaining = num.divmod(10)
    return UNDER_HUNDRED[num * 10] if remaining == 0
    return UNDER_HUNDRED[num * 10] + " " + UNDER_HUNDRED[remaining]
  end

  def check_sign(num)
    return num < 0 ? ([num.abs, 'negative ']) : ([num, ''])
  end
end

class Fixnum
  include ToWords
end

