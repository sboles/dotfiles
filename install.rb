#!/usr/bin/env ruby

# from http://errtheblog.com/posts/89-huba-huba

home = File.expand_path('~')

Dir['*'].each do |file|
  target = File.join(home, ".#{file}")
  next if target =~ /install/
  next if target =~ /vim/
  next if target =~ /vimrc/
  next if target =~ /dotbin/
  next if target =~ /clj/
  next if target =~ /terminal/
  next if target =~ /README/
  next if File.exists?(target)
  command = "ln -s '#{File.expand_path file}' '#{target}'"
  puts command
  `#{command}`
end

# git push on commit
`echo 'git push' > .git/hooks/post-commit`
`chmod 755 .git/hooks/post-commit`


