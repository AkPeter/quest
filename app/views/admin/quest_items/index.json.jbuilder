json.array!([:admin, @quest_items]) do |quest_item|
  json.extract! quest_item, :id, :name, :quest_status_id
  json.url admin_quest_item_url(quest_item, format: :json)
end
