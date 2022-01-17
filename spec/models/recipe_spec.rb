require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { FactoryBot.build(:recipe) }
  let(:ingredient) { FactoryBot.build(:ingredient) }

  # model fields
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:prep_time).of_type(:integer) }
  it { is_expected.to have_db_column(:cook_time).of_type(:integer) }
  it { is_expected.to have_db_column(:total_time).of_type(:integer) }
  it { is_expected.to have_db_column(:rate).of_type(:decimal) }
  it { is_expected.to have_db_column(:budget).of_type(:string) }
  it { is_expected.to have_db_column(:people_quantity).of_type(:integer) }

  # model associations
  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:difficulty) }
  it { is_expected.to have_and_belong_to_many(:ingredients) }

  # model validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:ingredients) }

  context 'associated models validations' do
    context 'when associated models not attached' do
      let(:invalid_recipe) do
        Recipe.new(
          name: 'Recipe name',
          ingredients: [ingredient]
        )
      end

      before { invalid_recipe.valid? }

      it 'model should be invalid' do
        expect(invalid_recipe.errors).to include :author
        expect(invalid_recipe.errors).to include :difficulty
      end
    end

    context 'when associated models attached' do
      let(:author) { FactoryBot.create(:author) }
      let(:difficulty) { FactoryBot.create(:difficulty) }
      let(:recipe) do
        Recipe.new(
          name: 'Recipe name',
          ingredients: [ingredient],
          author: author,
          difficulty: difficulty,
        )
      end

      it 'model should be valid' do
        expect(recipe.valid?).to be_truthy
      end
    end
  end
end
