#!/usr/bin/env ruby

# Copied from https://github.com/sajoku/dotfiles/blob/main/bin/connect-to-aws-instance.rb

require "open3"
require "json"

# Get a list of running instances
instances_command = [
  "aws",
  "ec2",
  "describe-instances",
  "--filters",
  "Name=tag-key,Values=Name",
  "--query",
  "Reservations[].Instances[].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}",
  "--output",
  "json"
]
stdout, stderr, status = Open3.capture3(*instances_command)

# Check if there was an error executing the command
if status.success?
  instances = JSON.parse(stdout)

  # Display numbered list of instances
  puts "Select an instance to connect to:"
  instances.each_with_index do |instance, i|
    instance_id = instance["Instance"]
    instance_name = instance["Name"]
    puts "[#{i + 1}] #{instance_id} (#{instance_name})"
  end

  # Prompt the user to enter the corresponding number
  instance_number = nil
  loop do
    print "Enter the number of the instance (or press Ctrl+C to quit): "
    instance_number = gets.chomp.to_i

    if instance_number.positive? && instance_number <= instances.length
      break
    else
      puts "Invalid input. Please enter a valid number."
    end
  end

  # Get the instance ID based on the selected number
  instance_id = instances[instance_number - 1]["Instance"]

  # Connect to the selected instance using AWS SSM
  puts "Connecting to instance #{instance_id}"
  system("aws", "ssm", "start-session", "--target", instance_id)
else
  puts "An error occurred while retrieving the instances:"
  puts stderr
end
