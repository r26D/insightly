require 'json'
require 'rest-client'
require 'logger'
require 'insightly/configuration'
require "active_support/core_ext"  #Needed for Hash.from_xml

require 'insightly/address_helper'
require 'insightly/contact_info_helper'
require 'insightly/link_helper'
require 'insightly/task_link_helper'
require 'insightly/tag_helper'


require 'insightly/base'
require 'insightly/base_data'
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
require "insightly/link"
require "insightly/tag"
require "insightly/user"
require "insightly/country"
require "insightly/currency"
require "insightly/team_member"
require "insightly/relationship"
require "insightly/opportunity_category"
require "insightly/task_category"
require "insightly/custom_field"
require "insightly/project"

