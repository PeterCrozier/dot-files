
# support using vi.  See https://github.com/jberkel/interactive_editor
# gem install interactive_editor
require 'rubygems'
require 'interactive_editor'
# using ed will invoke MacVim in an async window
ENV['EDITOR'] = "mvim"

# syntax colouring
begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

# rvm puts the version in the prompt, put it back to default
IRB.conf[:PROMPT_MODE] = :DEFAULT
