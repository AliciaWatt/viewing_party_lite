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
    # it { should validate_uniqueness_of(:email).scoped_to(:id).with_message('** Email Already Exists **') }

    describe '.not_hosts' do
    it "returns all the users but the passed user_id" do
      user_1 = create(:user, name: 'Abby', email: 'abby@mail.org')
      user_2 = create(:user, name: 'Bob', email: 'bob@mail.org')
      user_3 = create(:user, name: 'Christy', email: 'christy@mail.org')
      user_4 = create(:user, name: 'Dave', email: 'dave@mail.org')

      expect(User.not_host(user_2.id)).to eq([user_1, user_3, user_4])
    end
  end
  end
end
