require 'json'
require 'rest-client'
require 'logger'
require 'insightly/configuration'
require "active_support/core_ext"  #Needed for Hash.from_xml

require 'insightly/base'
require 'insightly/read_only'
require 'insightly/task'
require 'insightly/task_link'
require 'insightly/comment'
require 'insightly/opportunity'
require 'insightly/opportunity_state_reason'