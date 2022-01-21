# -*- ruby -*-
# Per https://github.com/nonsequitur/inf-ruby/issues/55
Pry.config.correct_indent = false if ENV["INSIDE_EMACS"]
# Per https://github.com/nonsequitur/inf-ruby/issues/88
Pry.color = true
