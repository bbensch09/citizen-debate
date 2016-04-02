json.array!(@debaters) do |debater|
  json.extract! debater, :id, :user_id, :record
  json.url debater_url(debater, format: :json)
end
