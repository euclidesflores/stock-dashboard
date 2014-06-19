# FIX-ME: Ideally it all would be moved to use a gem like dotenv
module TwitterVariables
  class Application < Rails::Application
     config.before_configuration do
       env_file = Rails.root.join("config", 'dashboard_variables.yml').to_s
       if File.exists?(env_file)
         YAML.load_file(env_file)[Rails.env].each do |k, v|
           ENV[k.to_s] = v
         end	 
       end	   
     end
  end
end
