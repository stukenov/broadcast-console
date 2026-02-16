require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "John Doe", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(name: nil, password: "password")
    expect(user).to_not be_valid
  end
  
  it "is not valid without a password" do
    user = User.new(name: "John Doe", password: nil)
    expect(user).to_not be_valid
  end
end
