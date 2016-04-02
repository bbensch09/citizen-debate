json.array!(@rounds) do |round|
  json.extract! round, :id, :debate_id, :round_number, :start_time, :end_time, :status
  json.url round_url(round, format: :json)
end
