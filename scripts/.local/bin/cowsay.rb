#!/usr/bin/env ruby

def cowsay
  max_len = 45
  text = ARGF.read
  len = if text.length < max_len
          text.length
        else
          max_len
        end

  text_lines = `echo "#{text}" | fold -sw#{len}`.lines.map(&:strip)
  text_lines.pop

  border = '-' * len
  puts ".#{border}."

  text_lines.each do |line|
    puts "|#{line.center(len, ' ')}|"
  end

  puts "'#{border}'"
  puts <<-COW
       \\      ^__^
           \\  (OO)\\_______
              (__)\       )\\/\\
                  ||----w |
                  ||     ||
  COW
end

cowsay
