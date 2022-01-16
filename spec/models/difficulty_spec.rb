require 'rails_helper'

RSpec.describe Difficulty, type: :model do
  let(:recipe) { FactoryBot.build(:recipe) }

  # model fields
  it { is_expected.to have_db_column(:name).of_type(:string) }

  # model associations
  it { is_expected.to have_many(:recipes) }

  # model validations
  it { is_expected.to validate_presence_of(:name) }
end
