json.array!(@charity_emails) do |charity_email|
  json.extract! charity_email, :id, :email
  json.url charity_email_url(charity_email, format: :json)
end
