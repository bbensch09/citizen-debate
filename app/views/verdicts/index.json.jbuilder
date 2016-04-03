json.array!(@verdicts) do |verdict|
  json.extract! verdict, :id, :status, :opinion_left, :opinion_right, :winner_id, :confirmed_judges, :confirmed_public
  json.url verdict_url(verdict, format: :json)
end
