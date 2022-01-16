require 'rails_helper'

RSpec.describe FillDb do
  describe '.call' do
    subject(:service) { described_class }

    before do
      allow(described_class).to receive(:download_file).and_return true
      allow(described_class).to receive(:file).and_return Rails.root.join('spec', 'fixtures', 'recipes.json')
      allow(described_class).to receive(:removes_zip_file).and_return true
    end

    context 'when json file not found' do
      before do
        allow(described_class).to receive(:file).and_return Rails.root.join('spec', 'fixtures', 'not_existing.json')
      end

      it 'is expecting DB to be empty' do
        service.call
        expect(Recipe.count).to eq 0
        expect(Author.count).to eq 0
        expect(Difficulty.count).to eq 0
      end
    end

    it 'is expecting to fill DB' do
      service.call
      expect(Recipe.count).to eq 3
      expect(Author.count).to eq 3
      expect(Difficulty.count).to eq 2
    end
  end
end
