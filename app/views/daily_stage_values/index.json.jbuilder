json.array!(@daily_stage_values) do |daily_stage_value|
  json.extract! daily_stage_value, :id
  json.url daily_stage_value_url(daily_stage_value, format: :json)
end
