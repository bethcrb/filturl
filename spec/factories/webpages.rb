# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  url           :string(2000)     default(""), not null
#  slug          :string(255)
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  content_type  :string(255)
#  meta_encoding :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_webpages_on_slug  (slug) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage do
    url 'http://www.google.com/'
    slug nil
    primary_ip '74.125.239.114'
    body '<html><head></head><body>MyText</body></html>'
    content_type nil
    meta_encoding nil

    factory :french_webpage do
      body '<html><head></head><body>Cette page web est en français.</body></html>'
    end

    factory :japanese_webpage do
      body '<html><head></head><body>このウェブページは日本語である。</body></html>'
    end

    factory :hebrew_webpage do
      body '<html><head></head><body>דף אינטרנט זה הוא בעברית.</body></html>'
    end

    factory :russian_webpage do
      body '<html><head></head><body>Данная веб-страница на русском языке.</body></html>'
    end
  end
end
