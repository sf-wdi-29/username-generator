# Make sure to run the tests in your /spec folder
# Run `rspec /spec/username_spec.rb` to get started.

$usernames = {}

def format_name(first, last)
  return nil if first.empty? || last.empty?
  first = first.gsub(/[^a-zA-Z]/, '')
  last = last.gsub(/[^a-zA-Z]/, '')
  (first[0] + last).downcase
end

def format_year(year)
  year.to_s[-2..-1] if year > 999 && year < 3000
end

def check_privilege(level = 0)
  %w(user seller manager admin)[level.to_i] || 'admin'
end

def user_type_prefix(level = 0)
  level.zero? ? '' : "#{check_privilege(level)}-"
end

def build_username(first, last, year, level = 0)
  "#{user_type_prefix(level)}#{format_name(first, last)}#{format_year(year)}"
end

def generate_username(first, last, year, level = 0)
  default_name = build_username(first, last, year, level)
  if $usernames[default_name]
    counter = 1
    counter += 1 while $usernames["#{default_name}_#{counter}"]
    default_name = "#{default_name}_#{counter}"
  end
  $usernames[default_name] = true
  default_name
end
