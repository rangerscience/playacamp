require 'csv'

namespace :importers do
  desc "Imports the camp spreadsheet"
  task :import, [:filename] => :environment do |t, args|
    data = {}
    CSV.foreach(args[:filename], :headers => true) do |row|
      data[row.fields[2]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
    end

    data.each do |name, entry|
      puts User.upsert_from_csv_entry entry
    end
  end

end
