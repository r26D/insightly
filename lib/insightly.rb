require 'json'
require 'rest-client'
require 'logger'
require 'insightly/configuration'
require "active_support/core_ext"  #Needed for Hash.from_xml

require 'insightly/address_helper'
require 'insightly/contact_info_helper'
require 'insightly/base'
require 'insightly/read_write'
require 'insightly/read_only'
require "insightly/address"
require "insightly/contact_info"
require 'insightly/contact'
require 'insightly/task'
require 'insightly/task_link'
require 'insightly/comment'
require 'insightly/opportunity_state_reason'
require 'insightly/opportunity'
require 'insightly/organisation'
