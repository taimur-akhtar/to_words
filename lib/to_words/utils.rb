module ToWords
  module Utils
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
end
