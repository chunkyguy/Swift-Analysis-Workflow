#!/usr/bin/env ruby
#
# Parse a Xcode build log and write worst 25 performing functions in terms of compile times
#   $ ruby swift-analysis.rb SomeLog.xcactivitylog output.txt

require 'pathname'

# parse arguments
exit 1 unless ARGV[0]

in_file_path = File.expand_path("#{ARGV[0]}")
out_file_path = File.expand_path("#{ARGV[1]}")

exit 1 unless File.extname(in_file_path) == '.xcactivitylog'

basename = Pathname.new("#{in_file_path}").basename.to_s
gzipped_file_name = basename + '.gz'
tmp_gzipped_file_name = "/tmp/#{gzipped_file_name}"

# Create base file name and translated base file name
unzipped_base_file_name = "/tmp/#{basename}"
unzipped_translated_base_file_name = "/tmp/#{basename}-translated"

# Create base analyze file name and path
analyzed_file_name = "#{basename}-swift-analysis.txt"
analyzed_tmp_file_name = "/tmp/#{analyzed_file_name}"

# Make a copy of the file with the gzip extension
copy_status = `cp "#{in_file_path}" "#{tmp_gzipped_file_name}"`
unzip_status = `gzip -d #{tmp_gzipped_file_name}`
translate_status = `tr '\r' '\n' <#{unzipped_base_file_name} >#{unzipped_translated_base_file_name}`
analysis_status = `cat #{unzipped_translated_base_file_name} | grep '^[0-9]*.[0-9]ms' | sort -nr > "#{analyzed_tmp_file_name}"`
analysis_status = `cat #{analyzed_tmp_file_name} | head -25 | awk '{n=split($0,a,"/"); print a[n]}' > "#{out_file_path}.log"`

# save output
copy_desktop_status = `cp #{analyzed_tmp_file_name} #{out_file_path}-full.log`

# clean up
removal_status = `rm #{unzipped_base_file_name} #{unzipped_translated_base_file_name} #{analyzed_tmp_file_name}`
