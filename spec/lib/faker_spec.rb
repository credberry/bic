# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Bic::Faker do

  it 'generates valid bic and account' do
    bic = Bic::Faker.bic
    expect(valid_bic?(bic)).to eq(true)

    account = Bic::Faker.account(bic)
    expect(valid_account?(bic, account)).to eq(true)
  end
end
