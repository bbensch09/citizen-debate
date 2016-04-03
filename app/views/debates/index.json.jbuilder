json.array!(@debates) do |debate|
  json.extract! debate, :id, :affirmative_id, :negative_id, :judge_left_id, :judge_right_id, :status, :start_date, :start_time, :topic_id
  json.url debate_url(debate, format: :json)
end
