# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_url_and_user_id  (url,user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_request do
    url 'http://www.google.com/'
    user

    trait :big5 do
      url 'http://www.books.com.tw/'
    end

    trait :eucjp do
      url 'http://www.rakuten.co.jp/'
    end

    trait :euckr do
      url 'http://hankyung.com/'
    end

    trait :gb2312 do
      url 'http://www.qq.com/'
    end

    trait :gbk do
      url 'http://www.sohu.com/'
    end

    trait :iso885901 do
      url 'http://todosobremosquitos.com.ar/'
    end

    trait :iso885902 do
      url 'http://www.wiocha.pl/'
    end

    trait :iso885909 do
      url 'http://www.radikal.com.tr/'
    end

    trait :iso885915 do
      url 'http://www.marca.com/'
    end

    trait :shiftjis do
      url 'http://www.yomiuri.co.jp/'
    end

    trait :windows874 do
      url 'http://www.thailandpost.com/'
    end

    trait :windows1250 do
      url 'http://www.idnes.cz/'
    end

    trait :windows1251 do
      url 'http://www.kinopoisk.ru/'
    end

    trait :windows1252 do
      url 'http://www.leboncoin.fr/'
    end

    trait :windows1254 do
      url 'http://meb.gov.tr/'
    end

    trait :windows1256 do
      url 'http://youm7.com/'
    end
  end
end
