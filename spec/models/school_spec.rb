require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { FactoryBot.create(:random_school) }
  let(:recipient) { FactoryBot.create(:random_recipient, school_id: school.id) }
  let(:order) { FactoryBot.create(:order, school_id: school.id) }

  describe 'associations' do
    it { should have_many(:recipients) }
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }

    it 'is valid with valid attributes' do
      school = School.create(name: 'School1', address: 'Address1')
      expect(school).to be_valid
    end
  end

  describe 'methods' do
    let(:order_item) { FactoryBot.create(:order_item, school_id: school.id, recipient_id: recipient.id) }
    it 'Retrieves the orders from a school in a given date ' do
      expect(school.orders_on(order.date).count).to eq 1
    end

    it 'Counts the number of gifts order for a given date' do
      expect(school.ordered_gifts_on(order.date)).to eq 0
    end
  end
end
