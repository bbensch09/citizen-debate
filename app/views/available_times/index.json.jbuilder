json.array!(@available_times) do |available_time|
  json.extract! available_time, :id, :debate_id, :proposed_by, :proposed_to, :proposed_time, :status
  json.url available_time_url(available_time, format: :json)
end
