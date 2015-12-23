# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  firstname  :string
#  lastname   :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'
require 'pry'

RSpec.describe Contact, type: :model do
  describe "validates spec" do
    it 'validate firstname presence' do
      contact = build(:contact, firstname: nil)
      contact.valid?
      expect(contact.errors[:firstname]).to include 'can\'t be blank'
      expect(contact.phones.map(&:phone_type)).to eq ['home_phone', 'work_phone', 'mobile_phone']
    end
  end
end
