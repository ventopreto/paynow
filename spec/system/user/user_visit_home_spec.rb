require 'rails_helper'

describe 'User visit home' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('Boas vindas ao Paynow')
  end
end