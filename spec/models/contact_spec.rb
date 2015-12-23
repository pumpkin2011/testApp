require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validates spec" do
    it 'validate firstname presence' do
      contact = FactoryGirl.build(:contact, firstname: nil)
      contact.valid?
      expect(contact.errors[:firstname]).to include 'can\'t be blank'
    end
  end
end
