# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  url           :string(2000)     default(""), not null
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  content_type  :string(255)
#  meta_encoding :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage do
    url 'http://www.google.com/'
    primary_ip '74.125.239.114'
    body '<html><head></head><body>MyText</body></html>'
    content_type nil
    meta_encoding nil
  end

  trait :big5 do
    url 'http://www.books.com.tw/'
    body File.read(Rails.root.join('spec/fixtures/encodings/big5.html'))
  end

  trait :eucjp do
    url 'http://www.rakuten.co.jp/'
    body File.read(Rails.root.join('spec/fixtures/encodings/eucjp.html'))
  end

  trait :euckr do
    url 'http://hankyung.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/euckr.html'))
  end

  trait :gb2312 do
    url 'http://www.qq.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/gb2312.html'))
  end

  trait :gbk do
    url 'http://www.sohu.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/gbk.html'))
  end

  trait :iso885901 do
    url 'http://todosobremosquitos.com.ar/'
    body File.read(Rails.root.join('spec/fixtures/encodings/iso885901.html'))
  end

  trait :iso885902 do
    url 'http://www.wiocha.pl/'
    body File.read(Rails.root.join('spec/fixtures/encodings/iso885902.html'))
  end

  trait :iso885909 do
    url 'http://www.radikal.com.tr/'
    body File.read(Rails.root.join('spec/fixtures/encodings/iso885909.html'))
  end

  trait :iso885915 do
    url 'http://www.marca.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/iso885915.html'))
  end

  trait :shiftjis do
    url 'http://www.yomiuri.co.jp/'
    body File.read(Rails.root.join('spec/fixtures/encodings/shiftjis.html'))
  end

  trait :windows874 do
    url 'http://www.thailandpost.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows874.html'))
  end

  trait :windows1250 do
    url 'http://www.idnes.cz/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows1250.html'))
  end

  trait :windows1251 do
    url 'http://www.kinopoisk.ru/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows1251.html'))
  end

  trait :windows1252 do
    url 'http://bigresource.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows1252.html'))
  end

  trait :windows1254 do
    url 'http://meb.gov.tr/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows1254.html'))
  end

  trait :windows1256 do
    url 'http://youm7.com/'
    body File.read(Rails.root.join('spec/fixtures/encodings/windows1256.html'))
  end
end
