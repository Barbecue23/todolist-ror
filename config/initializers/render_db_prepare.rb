# Render free/native deploys often start Puma directly without a release command.
# Ensure schema exists before the app serves traffic.
if ENV["RENDER"] == "true"
  Rails.application.config.after_initialize do
    ActiveRecord::Tasks::DatabaseTasks.prepare_all
  end
end
