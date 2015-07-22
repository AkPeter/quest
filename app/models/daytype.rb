class Daytype < ActiveRecord::Base
  has_many :price_presets
  has_many :tickets
end
