puts "Create default admin user"
Erp::User.create(
  email: "admin@dogoviet.vn",
  password: "aA456321!@#",
  name: "Trần Ngọc Phương Nhung",
  backend_access: true,
  confirmed_at: Time.now-1.day,
  active: true
) if Erp::User.where(email: "admin@dogoviet.vn").empty?