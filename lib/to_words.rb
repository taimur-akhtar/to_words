require "to_words/version"

module ToWords
  UNDER_HUNDRED_EN =
    {""=>"",
     0=>"zero",
     1=>"one",
     2=>"two",
     3=>"three",
     4=>"four",
     5=>"five",
     6=>"six",
     7=>"seven",
     8=>"eight",
     9=>"nine",
     10=>"ten",
     11=>"eleven",
     12=>"twelve",
     13=>"thirteen",
     14=>"fourteen",
     15=>"fifteen",
     16=>"sixteen",
     17=>"seventeen",
     18=>"eighteen",
     19=>"nineteen",
     20=>"twenty",
     30=>"thirty",
     40=>"forty",
     50=>"fifty",
     60=>"sixty",
     70=>"seventy",
     80=>"eighty",
     90=>"ninety",
     100=>"one hundred",
     1000=>"one thousand"}

  UNDER_HUNDRED_ID =
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

  DIVISIONS_EN = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintrillion"]
  DIVISIONS_ID = ["", "ribu", "juta", "biliun", "triliun", "kuadriliun", "kuantatiliun"]

  HUNDRED_IN_WORD_EN = " hundred "
  HUNDRED_IN_WORD_ID = " ratus "

  HUNDRED_IN_WORD_AND_EN = " hundred and "
  HUNDRED_IN_WORD_AND_ID = " ratus "

  def to_words(language = "en")
    set_language(language)

    num = self.to_i
    num, sign = check_sign(num)
    return (sign + under_hundred(num)) if (num <= 100 || num == 1000)
    counter = 0
    result = []
    while num != 0
      num, remaining = num.divmod(1000)
      temp_result = result_below_one_thousand(remaining, counter)
      result << temp_result + " " + @@divisions[counter] + " " if temp_result != ''
      result[result.length - 1] = under_hundred(1000) if counter == 1 && remaining == 1
      counter += 1
    end
    return sign + result.reverse.join("").rstrip
  end

  def result_below_one_thousand(num, counter)
    hundred, remaining = num.divmod(100)
    hundred_in_word = " "
    hundred_in_word_and = " "
    if hundred > 1
      hundred_in_word = @@hundred_in_word
      hundred_in_word_and = @@hundred_in_word_and
    end
    hundred = hundred * 100 if hundred == 1

    return under_hundred(hundred) + hundred_in_word + under_hundred(remaining)        if hundred != 0 && remaining != 0 && counter != 0
    return under_hundred(hundred) + hundred_in_word_and + under_hundred(remaining)    if hundred != 0 && remaining != 0
    return under_hundred(remaining)                                                   if hundred == 0 && remaining != 0
    return under_hundred(hundred) + hundred_in_word                                   if hundred != 0 && remaining == 0
    return ''
  end

  def under_hundred(num)
    words = @@words
    return words[num] if num < 20
    num, remaining = num.divmod(10)
    return words[num * 10] if remaining == 0
    return words[num * 10] + " " + words[remaining]
  end

  def set_language(language)
    if language == "en"
      @@words = UNDER_HUNDRED_EN
      @@divisions = DIVISIONS_EN
      @@hundred_in_word = HUNDRED_IN_WORD_EN
      @@hundred_in_word_and = HUNDRED_IN_WORD_AND_EN
    end
    if language == "id"
      @@words = UNDER_HUNDRED_ID
      @@divisions = DIVISIONS_ID
      @@hundred_in_word = HUNDRED_IN_WORD_ID
      @@hundred_in_word_and = HUNDRED_IN_WORD_AND_ID
    end
  end

  def check_sign(num)
    return num < 0 ? ([num.abs, 'negative ']) : ([num, ''])
  end
end

class Fixnum
  include ToWords
end

