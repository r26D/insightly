insightly
=========

This is a rest client library to handle talking to http://Insight.ly

The official API for Insigh.ly was released on August 12, 2012.  This library is in the very early stages of implementing access to everything expose in
that API.  The focus is primarily on opportunities and tasks.

Getting Started
=========

Besides including the gem you need to use the Configuration class to set your API key.

```ruby
  Insightly::Configuration.api_key = "XXX-XXX-XXX-XXXX"
```

This key is provided to you in your User Settings section of Insight.ly.


Custom Fields
===========

Some of the resources allow you to have custom fields. They are returned as number fields (c.f. OPPORTUNITY_FIELD_1).  You can call them directly in your code by
that name.

```ruby
opportunity = Insightly::Opportunity.new(1000)
opportunity.opportunity_field_1 = "Ron Campbell"
```

To make your code more readable, you can add in labels for those fields so you can refer to them more readable. The fields are lined up based on the order they are
provided to the setting. For example, Opportunities support 10 custom fields. You can provide up to 10 labels to match all 10 fields. You can set this up in the same place
you set your API key.

```ruby
Insightly::Configuration.custom_fields_for_opportunities(:person_who_referred_them, :where_they_saw_the_ad)
opportunity = Insightly::Opportunity.new(1000)
opportunity.opportunity_field_1 = "Ron Campbell"
opportunity.person_who_referred_them == "Ron Campbell"
```

Opportunity State Reasons
========

The API allows you to change the state of an opportunity directly by modifying the OPPORTUNITY_STATE field. This doesn't store the reason
that the opportunity state was changed.  In order to store the reason, you have to PUT to OpportunityStateChange with a valid OpportunityStateReason.
OpportunityStateReasons can only be created manually in the web interface and then referred to via the API.

This is important if you want to have it show you the state changes in the Opportuity details. Direct modifications don't create a log entry.
Whereas the log entry is created if you do create them. In order for your code to work, you need to make sure you have valid Opportunity State Reasons for all the states.

We default to creating two for open -  "Created by API", and "Reopened by API". This allows us to set those as reasons if they exist.
