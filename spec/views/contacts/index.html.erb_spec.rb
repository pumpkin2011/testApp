require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email"
      ),
      Contact.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
