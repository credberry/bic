# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Bic::Validation do

  let(:valid_bic)       { '044525593'  }
  let(:invalid_bic)     { '0498057467' }
  let(:valid_account)   { '40108110400001020001' }
  let(:invalid_account) { '406028107000000000255' }

  context :validate_bic do
    it 'returns :invalid_bic_length for nil object' do
      expect(validate_bic(nil)).to eq(:invalid_bic_length)
    end

    it 'returns :invalid_bic_length when bic is shorten than needed' do
      expect(validate_bic('1' * (Bic::BIC_LENGTH - 1))).to eq(:invalid_bic_length)
    end

    it 'returns :invalid_bic_length when bic is longer than needed' do
      expect(validate_bic('1' * (Bic::BIC_LENGTH + 1))).to eq(:invalid_bic_length)
    end

    it 'returns :invalid_country_code for not russian banks' do
      expect(validate_bic('051254637')).to eq(:invalid_country_code)
    end

    it 'returns :invalid_organization_code for not russian banks' do
      expect(validate_bic('041254005')).to eq(:invalid_organization_code)
    end

    it 'returns :valid for valid bic' do
      expect(validate_bic(valid_bic)).to eq(:valid)
    end
  end

  context :validate_account do

    it 'validates bic first' do
      allow(self).to receive(:validate_bic).with(valid_bic).once { :valid }
      expect(validate_account(valid_bic, nil)).to eq(:invalid_account_length)
    end

    it 'returns :invalid_account_length for nil object' do
      expect(validate_account(valid_bic, nil)).to eq(:invalid_account_length)
    end

    it 'returns :invalid_account_length when account is shorten than needed' do
      expect(validate_account(valid_bic, '1' * (Bic::ACCOUNT_LENGTH - 1))).to eq(:invalid_account_length)
    end

    it 'returns :invalid_account_length when account is longer than needed' do
      expect(validate_account(valid_bic, '1' * (Bic::ACCOUNT_LENGTH + 1))).to eq(:invalid_account_length)
    end

    it 'returns :invalid_control_code when code is broken' do
      expect(validate_account(valid_bic, '40602810700000000024')).to eq(:invalid_control_code)
    end

    it 'returns :valid for valid bic and account' do
      expect(validate_account(valid_bic, valid_account)).to eq(:valid)
    end
  end

  context :valid_bic? do
    it 'calls validate_bic' do
      allow(self).to receive(:validate_bic).with(valid_bic).once { :valid }
      expect(valid_bic?(valid_bic)).to eq(true)
    end

    it 'returns false for invalid_bic' do
      expect(valid_bic?(invalid_bic)).to eq(false)
    end
  end

  context :valid_account? do
    it 'calls validate_account' do
      allow(self).to receive(:validate_account).with(valid_bic, valid_account).once { :valid }
      expect(valid_account?(valid_bic, valid_account)).to eq(true)
    end

    it 'returns false for invalid account' do
      expect(valid_account?(valid_bic, invalid_account)).to eq(false)
    end
  end
end
