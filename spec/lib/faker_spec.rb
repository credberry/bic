# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Bic::Faker do

  it 'generates valid bic and account' do
    bic = Bic::Faker.bic
    valid_bic?(bic).should == true

    account = Bic::Faker.account(bic)
    valid_account?(bic, account).should == true
  end

end