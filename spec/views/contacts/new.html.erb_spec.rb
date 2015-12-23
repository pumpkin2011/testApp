require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_firstname[name=?]", "contact[firstname]"

      assert_select "input#contact_lastname[name=?]", "contact[lastname]"

      assert_select "input#contact_email[name=?]", "contact[email]"
    end
  end
end
