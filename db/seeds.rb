Todo.destroy_all

samples = [
  { title: "ออกแบบหน้าแรก FORGE ให้คมและจำง่าย", priority: 2, completed: false },
  { title: "เขียน acceptance criteria สำหรับฟีเจอร์ toggle", priority: 1, completed: false },
  { title: "รีวิวโค้ดกับทีม 15 นาที", priority: 1, completed: true },
  { title: "เตรียม demo สำหรับ stakeholder", priority: 2, completed: false },
  { title: "อัปเดต README วิธีรันโปรเจ็ค", priority: 0, completed: false }
]

samples.each_with_index do |attrs, index|
  Todo.create!(attrs.merge(position: index + 1))
end

puts "Seeded #{Todo.count} todos"
