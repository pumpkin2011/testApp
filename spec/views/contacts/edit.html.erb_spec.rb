require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input#contact_firstname[name=?]", "contact[firstname]"

      assert_select "input#contact_lastname[name=?]", "contact[lastname]"

      assert_select "input#contact_email[name=?]", "contact[email]"
    end
  end
end
