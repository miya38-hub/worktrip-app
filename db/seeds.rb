Admin.find_or_create_by!(email_address: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end