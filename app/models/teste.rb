domain = 'codeplay@gmail.com'.split('@')[1]

emails = %w[codeplay@gmail.com codeplay@yahoo.com x@gmail.com]
domain = []
emails.each do |email| 
  domain.append( email.split("@")[1])
end
puts domain.count('gmail.com')