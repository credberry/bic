# -*- encoding : utf-8 -*-

require File.expand_path("../../bic", __FILE__)

module Bic
  module Validation

    # правильные коды организаций
    VALID_ORG_CODES = [0, 1, 2] + (50...999).to_a.freeze

    # для расчета ключа
    ACCOUNT_WEIGHTS = [7, 1, 3].freeze

    BIC_REGEXP = Regexp.compile(/\A\d{#{Bic::BIC_LENGTH}}\z/)
    ACCOUNT_REGEXP = Regexp.compile(/\A\d{#{Bic::ACCOUNT_LENGTH}}\z/)

    def validate_bic(bic)
      return :invalid_bic_length unless bic =~ BIC_REGEXP

      country_code = bic[0..1].to_i
      return :invalid_country_code unless country_code == 4

      org_code = bic[6..8].to_i
      return :invalid_organization_code unless VALID_ORG_CODES.include?(org_code)

      :valid
    end

    def valid_bic?(bic)
      :valid == validate_bic(bic)
    end

    # Проверка соответствия БИК номеру счета
    def validate_account(bic, account)
      bic_validation = validate_bic(bic)
      return bic_validation unless bic_validation == :valid

      return :invalid_account_length unless account =~ ACCOUNT_REGEXP

      return :invalid_control_code unless valid_control_code?(bic, account)

      :valid
    end

    # Проверка контрольного ключа
    def valid_control_code?(bic, account)
      return false unless bic =~ BIC_REGEXP
      return false unless account =~ ACCOUNT_REGEXP

      details = [bic[-3..-1], account].join

      mult_results = details.split('').map.with_index do |number, i|
        number.to_i * ACCOUNT_WEIGHTS[i % ACCOUNT_WEIGHTS.size]
      end

      (mult_results.inject(0) {|sum, value| sum + (value % 10)} % 10).zero?
    end

    def valid_account?(bic, account)
      :valid == validate_account(bic, account)
    end
  end
end
