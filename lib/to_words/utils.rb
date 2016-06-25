require_relative './under_hundred.rb'
module ToWords
  module Utils
    include UnderHundred

    def result_below_one_thousand(num, counter)
      hundred, remaining = num.divmod(100)

      return higher_than_hundred(hundred, remaining, counter) if hundred != 0
      UNDER_HUNDRED[remaining] if hundred == 0 && remaining != 0
    end

    def higher_than_hundred(hundred, remaining, counter)
      if remaining != 0
        return UNDER_HUNDRED[hundred] + ' Hundred ' + UNDER_HUNDRED[remaining] if counter != 0
        return UNDER_HUNDRED[hundred] + ' Hundred and ' + UNDER_HUNDRED[remaining]
      end
      return UNDER_HUNDRED[hundred] + ' Hundred ' if remaining == 0
    end

    def check_sign(num)
      num < 0 ? [num.abs, 'negative '] : [num, '']
    end

    def numerical?(num)
      Integer(num)
    rescue
      raise 'A whole number is expected'
    end
  end
end
