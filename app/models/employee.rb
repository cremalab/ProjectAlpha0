class Employee < ActiveRecord::Base
  has_many :tasks


  def self.get_employees(api_key, workspace_id)
    p "here"
    url = "https://app.asana.com/api/1.0/workspaces/#{workspace_id}/users/"
    params = "?opt_fields=email,name"
    uri = URI.parse(url + params)
    employees = HttpHelper.get_request(uri, api_key)

    employees.each do |employee|
      existing_employee = Employee.where(asana_id: employee["id"].to_s)
      if existing_employee.empty?
        self.create(
          name: employee["name"],
          email: employee["email"],
          asana_id: employee["id"]
        )
      end
    end

  end

end
