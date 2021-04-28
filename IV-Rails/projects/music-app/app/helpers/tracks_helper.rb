# frozen_string_literal: true

include ERB::Util

module TracksHelper
  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n").each { |line| line.prepend('♫ ').strip }.join("\n")
    "<pre>#{h(lines)}</pre>".html_safe
  end
end
