json.array!(@judges) do |judge|
  json.extract! judge, :id, :user_id, :slant_profile, :slant_historical
  json.url judge_url(judge, format: :json)
end
