json.array!([:admin, @picturesofwinners]) do |picturesofwinner|
  json.extract! picturesofwinner, :id, :quest_item_id, :goaldate, :besttime, :description, :photourl
  json.url admin_picturesofwinner_url(picturesofwinner, format: :json)
end
