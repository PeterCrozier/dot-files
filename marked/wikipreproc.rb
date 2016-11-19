#!/usr/bin/env ruby

# preprocessor filtering stdin to stdout
# changing [name](!) to wiki links to name

Encoding.default_external = "UTF-8"

# match [tag](!) or [tag](!othername)
link_pattern = /\[(.+?)\]\((!.*?)\)/

ARGF.each do |line|
  line2 = line.gsub(link_pattern) do |m|
    t1 = $1
    t2 = $2
    t = nil
    if t2 == "!"
      # generate link from name, forcing first character to upper case
      t = t1.gsub(/ /, "_")
      t = t[0].upcase + t[1..-1]
    else
      # drop the ! but otherwise leave as is
      t = t1[1..-1]
    end
    "[#{t1}](https://en.wikipedia.org/wiki/#{t})"
  end
  print line2
end
