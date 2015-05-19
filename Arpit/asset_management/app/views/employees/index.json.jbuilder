json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last_name, :email, :employee_number, :designation, :technology, :department, :location_id, :join_date, :resign_date, :skype_id, :pm_tool_id, :pandian_id, :wiki_id, :sapience_id, :helpdesk_id
  json.url employee_url(employee, format: :json)
end
