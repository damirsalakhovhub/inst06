# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create test users
owner_user = User.find_or_create_by!(email: 'owner@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

admin_user = User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

member_user = User.find_or_create_by!(email: 'member@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

guest_user = User.find_or_create_by!(email: 'guest@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# Create organizations with different plans
org1 = Organization.find_or_create_by!(name: 'Acme Corp') do |o|
  o.plan = 'premium'
end

org2 = Organization.find_or_create_by!(name: 'Startup Inc') do |o|
  o.plan = 'basic'
end

# Create memberships with different roles
Membership.find_or_create_by!(user: owner_user, organization: org1) do |m|
  m.role = 'owner'
end

Membership.find_or_create_by!(user: admin_user, organization: org1) do |m|
  m.role = 'admin'
end

Membership.find_or_create_by!(user: member_user, organization: org1) do |m|
  m.role = 'member'
end

Membership.find_or_create_by!(user: guest_user, organization: org1) do |m|
  m.role = 'guest'
end

Membership.find_or_create_by!(user: owner_user, organization: org2) do |m|
  m.role = 'owner'
end

Membership.find_or_create_by!(user: admin_user, organization: org2) do |m|
  m.role = 'member'
end

# Create projects
project1 = Project.find_or_create_by!(name: 'Website Redesign', organization: org1) do |p|
  p.description = 'Complete redesign of company website'
end

project2 = Project.find_or_create_by!(name: 'Mobile App', organization: org1) do |p|
  p.description = 'Develop new mobile application'
end

project3 = Project.find_or_create_by!(name: 'Marketing Campaign', organization: org2) do |p|
  p.description = 'Q4 marketing campaign planning'
end

# Create tasks
Task.find_or_create_by!(title: 'Design homepage', project: project1) do |t|
  t.description = 'Create new homepage design mockups'
  t.status = 'pending'
  t.creator = owner_user
  t.assigned_user = admin_user
end

Task.find_or_create_by!(title: 'Implement navigation', project: project1) do |t|
  t.description = 'Build new navigation component'
  t.status = 'in_progress'
  t.creator = admin_user
  t.assigned_user = member_user
end

Task.find_or_create_by!(title: 'Write tests', project: project1) do |t|
  t.description = 'Add test coverage for new features'
  t.status = 'completed'
  t.creator = member_user
  t.assigned_user = member_user
end

Task.find_or_create_by!(title: 'API integration', project: project2) do |t|
  t.description = 'Integrate backend API'
  t.status = 'pending'
  t.creator = admin_user
  t.assigned_user = member_user
end

Task.find_or_create_by!(title: 'Create wireframes', project: project2) do |t|
  t.description = 'Design app wireframes'
  t.status = 'in_progress'
  t.creator = owner_user
  t.assigned_user = admin_user
end

Task.find_or_create_by!(title: 'Plan content strategy', project: project3) do |t|
  t.description = 'Develop content marketing strategy'
  t.status = 'pending'
  t.creator = owner_user
  t.assigned_user = nil
end

puts "Seed data created successfully!"
puts "- Users: #{User.count}"
puts "- Organizations: #{Organization.count}"
puts "- Memberships: #{Membership.count}"
puts "- Projects: #{Project.count}"
puts "- Tasks: #{Task.count}"
