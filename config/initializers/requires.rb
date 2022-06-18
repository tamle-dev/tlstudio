APP_VERSION = Rails.root.join('.version').read.strip.to_s.freeze

require 'identifier'
require 'base62'
require 'youtube_client'