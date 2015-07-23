require "to_words/version"

module ToWords

  # UNDER_HUNDRED = {""=>"", 0=>"nol", 1=>"satu", 2=>"dua", 3=>"tiga", 4=>"empat", 5=>"lima", 6=>"enam", 7=>"tujuh", 8=>"delapan", 9=>"sembilan", 10=>"sepuluh", 11=>"sebelas", 12=>"dua belas", 13=>"tiga belas", 14=>"empat belas", 15=>"lima belas", 16=>"enam belas", 17=>"tujuh belas", 18=>"delapan belas", 19=>"sembilan belas", 20=>"dua puluh", 21=>"dua puluh satu", 22=>"dua puluh dua", 23=>"dua puluh tiga", 24=>"dua puluh empat", 25=>"dua puluh lima", 26=>"dua puluh enam", 27=>"dua puluh tujuh", 28=>"dua puluh delapan", 29=>"dua puluh sembilan", 30=>"tiga puluh", 31=>"tiga puluh satu", 32=>"tiga puluh dua", 33=>"tiga puluh tiga", 34=>"thirty four", 35=>"thirty five", 36=>"thirty six", 37=>"thirty seven", 38=>"thirty eight", 39=>"thirty nine", 40=>"forty", 41=>"forty one", 42=>"forty two", 43=>"forty three", 44=>"forty four", 45=>"forty five", 46=>"forty six", 47=>"forty seven", 48=>"forty eight", 49=>"forty nine", 50=>"fifty", 51=>"fifty one", 52=>"fifty two", 53=>"fifty three", 54=>"fifty four", 55=>"fifty five", 56=>"fifty six", 57=>"fifty seven", 58=>"fifty eight", 59=>"fifty nine", 60=>"sixty", 61=>"sixty one", 62=>"sixty two", 63=>"sixty three", 64=>"sixty four", 65=>"sixty five", 66=>"sixty six", 67=>"sixty seven", 68=>"sixty eight", 69=>"sixty nine", 70=>"seventy", 71=>"seventy one", 72=>"seventy two", 73=>"seventy three", 74=>"seventy four", 75=>"seventy five", 76=>"seventy six", 77=>"seventy seven", 78=>"seventy eight", 79=>"seventy nine", 80=>"eighty", 81=>"eighty one", 82=>"eighty two", 83=>"eighty three", 84=>"eighty four", 85=>"eighty five", 86=>"eighty six", 87=>"eighty seven", 88=>"eighty eight", 89=>"eighty nine", 90=>"ninety", 91=>"ninety one", 92=>"ninety two", 93=>"ninety three", 94=>"ninety four", 95=>"ninety five", 96=>"ninety six", 97=>"ninety seven", 98=>"ninety eight", 99=>"ninety nine", 100=>"seratus"}

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
    return sign + result.reverse.join(" ").rstrip
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
    return UNDER_HUNDRED[num] if num == 100 || num <= 20
    num, remaining = num.divmod(10)
    return UNDER_HUNDRED[num * 10] + " " + UNDER_HUNDRED[remaining]
  end

  def check_sign(num)
    return num < 0 ? ([num.abs, 'negative ']) : ([num, ''])
  end
end

class Fixnum
  include ToWords
end

