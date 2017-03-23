domain = Domain.unscoped.where(:name => 'cloudapp.net').first_or_create
if domain.nil? || domain.errors.any?
  raise "Unable to create domain: #{format_errors domain}"
end
