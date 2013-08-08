namespace :http_status_codes do
  desc 'Import HTTP status codes'
  task import: :environment do
    require 'csv'

    file = Rails.root.join('vendor/resource/http-status-codes-1.csv')
    data = CSV.read(file, headers: true, header_converters: :downcase)

    data.each do |row|
      next if row['description'] == 'Unassigned'

      row = Hash[row.map { |k, v| [k.to_sym, v] }]
      HttpStatusCode.find_or_create_by!(row)
    end
  end
end
