# -*- encoding : utf-8 -*-

module Bic
  # длина БИК
  BIC_LENGTH = 9

  # длина номера счета
  ACCOUNT_LENGTH = 20
end


Dir[File.expand_path("../bic/**rb", __FILE__)].each { |f| require f }