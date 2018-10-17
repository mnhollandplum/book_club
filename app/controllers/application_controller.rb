class ApplicationController < ActionController::Base
  ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
  protect_from_forgery with: :exception
end
