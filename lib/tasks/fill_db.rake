# frozen_string_literal: true

desc 'Fetches recipes'
task :fill_database_from_file, [] => :environment do
  FillDb.call
end
