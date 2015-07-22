json.array!([:admin, @price_presets]) do |price_preset|
  json.extract! price_preset, :id, :quest_item_id, :daytype_id, :dt0, :dt1, :price
  json.url admin_price_preset_url(price_preset, format: :json)
end
