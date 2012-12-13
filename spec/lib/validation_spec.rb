# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Bic::Validation do

  let(:valid_bic)       { '044525593'  }
  let(:invalid_bic)     { '0498057467' }
  let(:valid_account)   { '40108110400001020001' }
  let(:invalid_account) { '406028107000000000255'}

  context :validate_bic do
    it 'returns :invalid_bic_length for nil object' do
      validate_bic(nil).should == :invalid_bic_length
    end

    it 'returns :invalid_bic_length when bic is shorten than needed' do
      validate_bic('1' * (Bic::BIC_LENGTH - 1)).should == :invalid_bic_length
    end

    it 'returns :invalid_bic_length when bic is longer than needed' do
      validate_bic('1' * (Bic::BIC_LENGTH + 1)).should == :invalid_bic_length
    end

    it 'returns :invalid_country_code for not russian banks' do
      validate_bic('051254637').should == :invalid_country_code
    end

    it 'returns :invalid_organization_code for not russian banks' do
      validate_bic('041254005').should == :invalid_organization_code
    end

    it 'returns :valid for valid bic' do
      validate_bic(valid_bic).should == :valid
    end
  end

  context :validate_account do

    it 'validates bic first' do
      mock(self).validate_bic(valid_bic + '123')
      validate_account(valid_bic, nil).should == :invalid_account_length
    end

    it 'returns :invalid_account_length for nil object' do
      validate_account(valid_bic, nil).should == :invalid_account_length
    end

    it 'returns :invalid_account_length when account is shorten than needed' do
      validate_account(valid_bic, '1' * (Bic::ACCOUNT_LENGTH - 1)).should == :invalid_account_length
    end

    it 'returns :invalid_account_length when account is longer than needed' do
      validate_account(valid_bic, '1' * (Bic::ACCOUNT_LENGTH + 1)).should == :invalid_account_length
    end

    it 'returns :invalid_control_code when code is broken' do
      validate_account(valid_bic, '40602810700000000024').should == :invalid_control_code
    end

    it 'returns :valid for valid bic and account' do
      validate_account(valid_bic, valid_account).should == :valid
    end
  end

  context :valid_bic? do
    it 'calls validate_bic' do
      mock(self).validate_bic(valid_bic)
      valid_bic?(valid_bic).should == true
    end

    it 'returns false for invalid_bic' do
      valid_bic?(invalid_bic).should == false
    end
  end

  context :valid_account? do
    it 'calls validate_account' do
      mock(self).validate_account(valid_bic, valid_account)
      valid_account?(valid_bic, valid_account).should == true
    end

    it 'returns false for invalid account' do
      valid_account?(valid_bic, invalid_account).should == false
    end
  end

end