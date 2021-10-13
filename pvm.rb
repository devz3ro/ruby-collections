#!/usr/local/bin/ruby

require 'creek'

puts "Enter the workbook file name (Example: pvm.xlsx)"
excel = gets.chomp
workbook = Creek::Book.new "#{excel}"
worksheets = workbook.sheets

host_wwpn_list = []
nums = 1

puts "Enter the host type (Example: RS)"
platform = gets.chomp
puts "Enter the target device (Example: SVC)"
target = gets.chomp
puts "Enter the vsan (Example: 100)"
vsan = gets.chomp

worksheets.each do |worksheet|
  worksheet.rows.each do |row|
    row_cells = row.values
    unless row_cells.grep(/^c05/).empty?
      host_wwpn_list << row_cells
    end
  end
end

host_wwpn_list.each do |host|
  print "\nzone name #{platform}-#{nums}-#{target}-#{host[2]} vsan #{vsan}"
  host[3].split("\n").each do |address|
    print "\nmember pwwn " + address
  end
  nums += 1
end
puts