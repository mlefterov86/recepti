# frozen_string_literal: true

require 'chronic_duration'

# Download 'recipes.json.gz', unzip and store in `/public/recipes.json`
# After data stored in DB, gz file is removed
class FillDb
  class << self
    FILE_NAME = 'recipes.json'.freeze

    def call
      download_file
      return puts "#{file} does not exist" unless File.exist?(file)

      parse_and_store_in_db(file)
      removes_zip_file
    end

    private

    attr_reader :author, :difficulty, :file

    def author
      author_name =  @recipe['author'] || 'Anonyme'
      @author = Author.find_or_create_by!(name: author_name)
    end

    def difficulty
      @difficulty = Difficulty.find_or_create_by!(name: @recipe['difficulty'])
    end

    def time_in_secs(time)
      if time.match(/\d+(h|H)(\s)?\d+/)
        time = time.split('h')
        ChronicDuration.parse(time.first + 'h') + ChronicDuration.parse(time.last + 'min')
      else
        ChronicDuration.parse(time)
      end
    end

    def parse_and_store_in_db(file)
      puts "===> Parsing file '#{file}' started!"
      n = 1
      File.foreach(file) do |line|
        @recipe = JSON.parse(line)
        Recipe.find_or_initialize_by(name: @recipe['name']).tap do |r|
          r.author = author
          r.difficulty = difficulty
          r.cook_time = time_in_secs(@recipe['cook_time'])
          r.prep_time = time_in_secs(@recipe['prep_time'])
          r.total_time = time_in_secs(@recipe['total_time'])
          r.rate = @recipe['rate']
          r.budget = @recipe['budget']
          r.people_quantity = @recipe['people_quantity']
          r.ingredients = @recipe['ingredients']
          r.save!
          puts "===> #{n} recipe data stored!"
          n += 1
        end
      end
      puts "===> Parsing file '#{file}' done!"
    end

    def download_file
      system 'wget https://d1sf7nqdl8wqk.cloudfront.net/recipes.json.gz'
      system "gzip -dc recipes.json.gz > #{Rails.root.join('public', 'recipes.json')}"
    end

    def file
      @file = Rails.root.join('public', FILE_NAME)
    end

    def removes_zip_file
      zip_file = Rails.root.join("#{FILE_NAME}.gz")
      File.delete(zip_file) if File.exist?(zip_file)
    end
  end
end
