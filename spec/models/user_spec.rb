require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:parties) }
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
    # it { should validate_uniqueness_of(:email).scoped_to(:id).with_message('** Email Already Exists **') }

    it "doesn't store passwords improperly" do
      user = create(:user, password: 'password', password_confirmation: 'password')
      expect(user).to_not have_attribute(:password)
      expect(user).to_not have_attribute(:password_confirmation)
      expect(user.password_digest).to_not eq('password')
    end
  end
end
