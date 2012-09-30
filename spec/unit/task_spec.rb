#METODO Refactor the link tests
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Task do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger


  end
  context "without network" do
    before(:each) do
      Insightly::Configuration.api_key = INSIGHTLY_API_KEY
      Insightly::Configuration.logger = Insightly::Configuration._debug_logger

      @task = Insightly::Task.new.build({
                                            "TASKLINKS" => {"OPPORTUNITY_ID" => 955454,
                                                            "TASK_LINK_ID" => 2744236,
                                                            "PROJECT_ID" => nil,
                                                            "CONTACT_ID" => nil,
                                                            "TASK_ID" => nil,
                                                            "ORGANIZATION_ID" => nil
                                            },
                                            "STATUS" => "NOT STARTED",
                                            "OWNER_USER_ID" => 226277,
                                            "RESPONSIBLE_USER_ID" => 226277,
                                            "PUBLICLY_VISIBLE" => true,
                                            "PARENT_TASK_ID" => nil,
                                            "COMPLETED_DATE_UTC" => nil,
                                            "CATEGORY_ID" => 125618,
                                            "PERCENT_COMPLETE" => 0,
                                            "START_DATE" => 0,
                                            "PRIORITY" => 2,
                                            "DETAILS" => "Make sure you log into the app to set the flag.",
                                            "DUE_DATE" => "2012-09-05 16:12:20",
                                            "PROJECT_ID" => nil,
                                            "COMPLETED" => false,
                                            "TASK_ID" => 3216775,
                                            "DATE_CREATED_UTC" => "2012-09-05 16:12:20",
                                            "TITLE" => "Flag the Customer"
                                        })


    end
    context "remote id" do
       it "should know if the remote id is set" do
         @task.remote_id = nil
         @task.remote_id?.should be_false
         @task.remote_id = ""
         @task.remote_id?.should be_false
         @task.remote_id = 1
         @task.remote_id?.should be_true
         @task.remote_id = "1"
         @task.remote_id?.should be_true
       end
       it "should know that the remote id and the task id are the same" do
         @task.remote_id.should == @task.task_id
       end
       it "should allow you to set the remote id" do
         @task.remote_id = 12
         @task.task_id.should == 12
       end
       it "should know the correct remote field" do
         @task.remote_id_field.should == "task_id"
       end
     end

     it "should be able to create a task" do
     end
     it "should have a url base" do
       @task.url_base.should == "Tasks"
     end
     it "should know the task id" do
       @task.task_id.should == 3216775
     end

     it "should allow you to build an object from a hash" do
       task = Insightly::Task.new.build({"TITLE" => "Other"})
       task.remote_data.should == {"TITLE" => "Other"}
     end
     it "should know the status of the task" do
       @task.status.should == "NOT STARTED"
     end
    context "comments" do
      before(:each) do

        @comment = Insightly::Comment.new.build({
                                                    "COMMENT_ID" => 132456,
                                                    "BODY" => "test comment",
                                                    "OWNER_USER_ID" => 12345,
                                                    "DATE_CREATED_UTC" => "2012-03-09 11:59:19",
                                                    "DATE_UPDATED_UTC" => "2012-03-09 11:59:19",
                                                    "FILE_ATTACHMENTS" =>
                                                        {
                                                            "FILE_ID" => 4567899,
                                                            "FILE_NAME" => "test.docx",
                                                            "CONTENT_TYPE" => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                            "FILE_SIZE" => 2489,
                                                            "FILE_CATEGORY_ID" => nil,
                                                            "OWNER_USER_ID" => 12345,
                                                            "DATE_CREATED_UTC" => "2012-03-09 11:59:20",
                                                            "DATE_UPDATED_UTC" => "2012-03-09 11:59:20",
                                                            "URL" => "/api/fileattachments/4567899"
                                                        }
                                                }
        )

      end
      it "should be able to fetch the comments" do
        Insightly::Task.any_instance.should_receive(:get_collection).with("Tasks/#{@task.task_id}/comments").and_return([@comment.remote_data])
        comments = @task.comments
        comments.length.should == 1
        comments.first.body.should == "test comment"
      end
      it "should be able to post a new comment" do
        value= "Test Comment #{Time.now}"
        @comment.body = value
        incoming_comment = Insightly::Comment.new.build({"BODY" => value})
        Insightly::Task.any_instance.should_receive(:post_collection).with("Tasks/#{@task.task_id}/comments", incoming_comment.remote_data.to_json).and_return(@comment.remote_data)
        #@task = Insightly::Task.new(3216775)

        result = @task.comment_on(value)
        result.comment_id.should_not be_nil
        result.body.should == value
      end
    end
    context "Status query" do
      before(:each) do
        @statuses = ["NOT STARTED", "IN PROGRESS", "WAITING", "COMPLETED", "DEFERRED"]
      end
      it "should know that is it not started" do
        @statuses.each do |s|
          @task.status = s
          s == "NOT STARTED" ? (@task.should be_not_started) : (@task.should_not be_not_started)
        end
      end
      it "should know that is it in progress" do
        @statuses.each do |s|
          @task.status = s
          s == "IN PROGRESS" ? (@task.should be_in_progress) : (@task.should_not be_in_progress)
        end
      end
      it "should know that is it waiting" do
        @statuses.each do |s|
          @task.status = s
          s == "WAITING" ? (@task.should be_waiting) : (@task.should_not be_waiting)
        end
      end
      it "should know that is it completed" do
        @statuses.each do |s|
          @task.status = s
          s == "COMPLETED" ? (@task.should be_completed) : (@task.should_not be_completed)
        end
      end
      it "should know that is it deferred" do
        @statuses.each do |s|
          @task.status = s
          s == "DEFERRED" ? (@task.should be_deferred) : (@task.should_not be_deferred)
        end
      end


    end
    context "link to an contact" do
      before(:each) do


        @contact = Insightly::Contact.build({

                                                        "VISIBLE_TO" => "OWNER",
                                                        "LAST_NAME" => "Other",
                                                        "FIRST_NAME" => "000 Test Contact #{Date.today}"

                                                    })

        @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                           "RESPONSIBLE_USER_ID" => 500,
                                           "OWNER_USER_ID" =>500,
                                           "TITLE" => "000 Test Task #{Date.today}"
                                          })
      end
      it "should be able to fetch the list of contact ids" do
        @contact.contact_id = 100
        @task.remote_id = 200
        @task.contact_ids.should == []
        @task.add_task_link(Insightly::TaskLink.add_contact(100))
        @task.add_task_link(Insightly::TaskLink.add_organisation(200))
        @task.contact_ids.should == [100]
      end
      it "should be able to fetch the list of contacts" do
        @task.remote_id = 200
        @task.contacts.should == []
        @contact.contact_id = 100
        @task.add_task_link(Insightly::TaskLink.add_contact(100))
        @task.add_task_link(Insightly::TaskLink.add_organisation(200))
        Insightly::Contact.should_receive(:new).with(100).and_return(@contact)
        @task.contacts.should == [@contact]
      end
      context "with an contact object" do


        it "should not pre-save the task if it has an id" do
          @task.task_id = 100
          @task.should_not_receive(:save)
          @contact.stub(:save)
          @task.add_contact(@contact)
        end
        it "should save the task before linking if it has never been saved" do
          @task.task_id.should be_nil
          @task.should_receive(:save).twice do
            @task.remote_id = 200
          end
          @contact.remote_id = 100
          @contact.stub(:save)
          @task.add_contact(@contact)
        end
        it "should save the contact before linking if it has never been saved" do
          @task.stub(:save)
          @contact.contact_id.should be_nil
          @contact.should_receive(:save)
          @task.add_contact(@contact)
        end
        it "should not pre-save the contact if it has an id" do
          @task.task_id = 100
          @task.stub(:save)
          @contact.contact_id = 100
          @contact.should_not_receive(:save)
          @task.add_contact(@contact)
        end
      end
      context "with an contact id" do

        it "should not do anything if the contact is nil" do
          @task.add_contact_id(nil).should be_false
        end

        it "should save the task before linking if it has never been saved" do
          @task.task_id.should be_nil
          @task.should_receive(:save).twice do
            @task.remote_id = 200
          end
          org = mock

          Insightly::Contact.stub(:new).with(100).and_return(org)
          @task.add_contact_id(100)
        end

      end

    end
    context "link to an opportunity" do
      before(:each) do


        @opportunity = Insightly::Opportunity.build({

                                                        "VISIBLE_TO" => "OWNER",
                                                        "BID_TYPE" => "Fixed Bid",
                                                        "ACTUAL_CLOSE_DATE" => nil,
                                                        "BID_CURRENTY" => "USD",
                                                        "OPPORTUNITY_STATE" => "Suspended",
                                                        "OPPORTUNITY_NAME" => "000 Test Opportunity #{Date.today}"

                                                    })

        @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                           "RESPONSIBLE_USER_ID" => 500,
                                           "OWNER_USER_ID" =>500,
                                           "TITLE" => "000 Test Task #{Date.today}"
                                          })
      end
      it "should be able to fetch the list of opportunity ids" do
        @opportunity.opportunity_id = 100
        @task.remote_id = 200
        @task.opportunity_ids.should == []
        @task.add_task_link(Insightly::TaskLink.add_opportunity(100))
        @task.add_task_link(Insightly::TaskLink.add_contact(200))
        @task.opportunity_ids.should == [100]
      end
      it "should be able to fetch the list of opportunities" do
        @task.remote_id = 200
        @task.opportunities.should == []
        @opportunity.opportunity_id = 100
        @task.add_task_link(Insightly::TaskLink.add_opportunity(100))
        @task.add_task_link(Insightly::TaskLink.add_contact(200))
        Insightly::Opportunity.should_receive(:new).with(100).and_return(@opportunity)
        @task.opportunities.should == [@opportunity]
      end
      context "with an opportunity object" do


        it "should not pre-save the task if it has an id" do
          @task.task_id = 100
          @task.should_not_receive(:save)
          @opportunity.stub(:save)
          @task.add_opportunity(@opportunity)
        end
        it "should save the task before linking if it has never been saved" do
          @task.task_id.should be_nil
          @task.should_receive(:save).twice do
            @task.remote_id = 200
          end
          @opportunity.remote_id = 100
          @opportunity.stub(:save)
          @task.add_opportunity(@opportunity)
        end
        it "should save the opportunity before linking if it has never been saved" do
          @task.stub(:save)
          @opportunity.opportunity_id.should be_nil
          @opportunity.should_receive(:save)
          @task.add_opportunity(@opportunity)
        end
        it "should not pre-save the opportunity if it has an id" do
          @task.task_id = 100
          @task.stub(:save)
          @opportunity.opportunity_id = 100
          @opportunity.should_not_receive(:save)
          @task.add_opportunity(@opportunity)
        end
      end
      context "with an opportunity id" do

        it "should not do anything if the opportunity is nil" do
          @task.add_opportunity_id(nil).should be_false
        end

        it "should save the task before linking if it has never been saved" do
          @task.task_id.should be_nil
          @task.should_receive(:save).twice do
            @task.remote_id = 200
          end
          org = mock

          Insightly::Opportunity.stub(:new).with(100).and_return(org)
          @task.add_opportunity_id(100)
        end

      end

    end
    context "link to an organisation" do
       before(:each) do
 
 
         @organisation = Insightly::Organisation.build({
 
                                                         "VISIBLE_TO" => "OWNER",
                                                         "ORGANISATION_NAME" => "000 Test Organisation #{Date.today}"
 
                                                     })
 
         @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                            "RESPONSIBLE_USER_ID" => 500,
                                            "OWNER_USER_ID" =>500,
                                            "TITLE" => "000 Test Task #{Date.today}"
                                           })
       end
       it "should be able to fetch the list of organisation ids" do
         @organisation.organisation_id = 100
         @task.remote_id = 200
         @task.organisation_ids.should == []
         @task.add_task_link(Insightly::TaskLink.add_organisation(100))
         @task.add_task_link(Insightly::TaskLink.add_contact(200))
         @task.organisation_ids.should == [100]
       end
       it "should be able to fetch the list of organisations" do
         @task.remote_id = 200
         @task.organisations.should == []
         @organisation.organisation_id = 100
         @task.add_task_link(Insightly::TaskLink.add_organisation(100))
         @task.add_task_link(Insightly::TaskLink.add_contact(200))
         Insightly::Organisation.should_receive(:new).with(100).and_return(@organisation)
         @task.organisations.should == [@organisation]
       end
       context "with an organisation object" do
 
 
         it "should not pre-save the task if it has an id" do
           @task.task_id = 100
           @task.should_not_receive(:save)
           @organisation.stub(:save)
           @task.add_organisation(@organisation)
         end
         it "should save the task before linking if it has never been saved" do
           @task.task_id.should be_nil
           @task.should_receive(:save).twice do
             @task.remote_id = 200
           end
           @organisation.remote_id = 100
           @organisation.stub(:save)
           @task.add_organisation(@organisation)
         end
         it "should save the organisation before linking if it has never been saved" do
           @task.stub(:save)
           @organisation.organisation_id.should be_nil
           @organisation.should_receive(:save)
           @task.add_organisation(@organisation)
         end
         it "should not pre-save the organisation if it has an id" do
           @task.task_id = 100
           @task.stub(:save)
           @organisation.organisation_id = 100
           @organisation.should_not_receive(:save)
           @task.add_organisation(@organisation)
         end
       end
       context "with an organisation id" do
 
         it "should not do anything if the organisation is nil" do
           @task.add_organisation_id(nil).should be_false
         end
 
         it "should save the task before linking if it has never been saved" do
           @task.task_id.should be_nil
           @task.should_receive(:save).twice do
             @task.remote_id = 200
           end
           org = mock
 
           Insightly::Organisation.stub(:new).with(100).and_return(org)
           @task.add_organisation_id(100)
         end
 
       end
 
     end
   

    context "TaskLinks" do

      it "should allow you to try to set it to nil" do
        @task = Insightly::Task.new
        @task.task_links = nil
        @task.task_links.should == []
      end
      it "should raise an error if you try to add a link but have not saved" do
        @task = Insightly::Task.new
        expect { @task.add_task_link(@link) }.to raise_error(ScriptError, "You must save the Insightly::Task before adding a link.")
      end

    end
  end
  context "with network" do
    before(:each) do
      Insightly::Configuration.api_key = INSIGHTLY_API_KEY
      Insightly::Configuration.logger = Insightly::Configuration._debug_logger
      @user = simple_insightly_user


    end
    it "should be able to load a task from a id" do

      VCR.use_cassette('load task by id') do
        @task = simple_insightly_task
        @task.reload
        @alt_task = Insightly::Task.new(@task.remote_id)
      end
      @alt_task.should == @task     
    end
    context "link to an contact" do
      before(:each) do



        @contact = Insightly::Contact.build({

                                                        "VISIBLE_TO" => "OWNER",
                                                        "LAST_NAME" => "Other",
                                                        "FIRST_NAME" => "000 Test Contact #{Date.today}"

                                                    })

        @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                           "RESPONSIBLE_USER_ID" => @user.user_id,
                                           "OWNER_USER_ID" => @user.user_id,
                                           "TITLE" => "000 Test Task #{Date.today}"
                                          })
      end

      context "with an contact object" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an contact to a task with object') do
            @task.add_contact(@contact)
            @task.reload
            @contact.reload
            @task.contacts.should == [@contact]
          end
        end


      end
      context "with an contact id" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an contact to a task by id') do
            @contact.save
            @task.add_contact_id(@contact.contact_id)
          end
          @task.contact_ids.should == [@contact.contact_id]
        end


      end

    end
    context "link to an opportunity" do
      before(:each) do


        @opportunity = Insightly::Opportunity.build({

                                                        "VISIBLE_TO" => "OWNER",
                                                        "BID_TYPE" => "Fixed Bid",
                                                        "ACTUAL_CLOSE_DATE" => nil,
                                                        "BID_CURRENTY" => "USD",
                                                        "OPPORTUNITY_STATE" => "Suspended",
                                                        "OPPORTUNITY_NAME" => "000 Test Opportunity #{Date.today}"

                                                    })

        @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                           "RESPONSIBLE_USER_ID" => @user.user_id,
                                           "OWNER_USER_ID" => @user.user_id,
                                           "TITLE" => "000 Test Task #{Date.today}"
                                          })
      end

      context "with an opportunity object" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an opportunity to a task with object') do
            @task.add_opportunity(@opportunity)
            @task.reload
            @opportunity.reload
            @task.opportunities.should == [@opportunity]
          end
        end


      end
      context "with an opportunity id" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an opportunity to a task by id') do
            @opportunity.save
            @task.add_opportunity_id(@opportunity.opportunity_id)
          end
          @task.opportunity_ids.should == [@opportunity.opportunity_id]
        end


      end

    end
    context "link to an organisation" do
      before(:each) do


        @organisation = Insightly::Organisation.build({

                                                             "VISIBLE_TO" => "OWNER",
                                                             "ORGANISATION_NAME" => "000 Test Organisation #{Date.today}"

                                                         })

        @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                           "RESPONSIBLE_USER_ID" => @user.user_id,
                                           "OWNER_USER_ID" => @user.user_id,
                                           "TITLE" => "000 Test Task #{Date.today}"
                                          })
      end

      context "with an organisation object" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an organisation to a task with object') do


            @task.add_organisation(@organisation)
            @task.reload
            @organisation.reload
            @task.organisations.should == [@organisation]
          end
        end


      end
      context "with an organisation id" do
        it "should be able to link to a task" do
          VCR.use_cassette('add an organisation to a task by id') do
            @organisation.save
            @task.add_organisation_id(@organisation.organisation_id)
          end
          @task.organisation_ids.should == [@organisation.organisation_id]
        end


      end

    end
    

    context "TaskLinks" do
      before(:each) do


        VCR.use_cassette('simple task') do
          @task = Insightly::Task.new.build({"STATUS" => "Completed",
                                             "RESPONSIBLE_USER_ID" => @user.user_id,
                                             "OWNER_USER_ID" => @user.user_id,
                                             "TITLE" => "000 Test Task #{Date.today}"
                                            })
          @task.save
        end
        @task.task_links.should == []
        VCR.use_cassette('organisation task link') do
          @organisation = Insightly::Organisation.build({
                                                            "VISIBLE_TO" => "OWNER",
                                                            "ORGANISATION_NAME" => "000 Test Org #{Date.today}"
                                                        })
          @organisation.save
          @link = Insightly::TaskLink.add_organisation(@organisation.remote_id)
        end
        VCR.use_cassette('opportunity task link') do
          @opportunity = Insightly::Opportunity.build({

                                                          "VISIBLE_TO" => "OWNER",
                                                          "BID_TYPE" => "Fixed Bid",
                                                          "ACTUAL_CLOSE_DATE" => nil,
                                                          "BID_CURRENTY" => "USD",
                                                          "OPPORTUNITY_STATE" => "Suspended",
                                                          "OPPORTUNITY_NAME" => "000 Test Opportunity #{Date.today}"

                                                      })
          @opportunity.save
          @link2 = Insightly::TaskLink.add_opportunity(@opportunity.remote_id)
        end
      end

      it "should allow you to update an link" do
        VCR.use_cassette('update task link for simple task') do
          @task.task_links.should == []
          @task.add_task_link(@link)

          @task.save
          @link = @task.task_links.first
          @link2.task_link_id = @link.task_link_id
          @task.task_links = [@link2]
          @task.save
          @task.reload
          @task.task_links.length.should == 1
          @task.task_links.first.opportunity_id.should == @opportunity.remote_id
        end

      end
      it "should allow you to add an link" do

        VCR.use_cassette('add task link to simple task') do
          @task.task_links.should == []
          @task.add_task_link(@link)

          @task.save
          @task.reload
          @task.task_links.length.should == 1
          @task.task_links.first.organisation_id.should == @organisation.remote_id
        end
      end
      it "should allow you to remove an link" do
        VCR.use_cassette('remove task link from simple task') do
          @task.task_links.should == []
          @task.add_task_link(@link)

          @task.save
          @task.task_links = []
          @task.save
          @task.reload
          @task.task_links.length.should == 0
        end

      end
      it "should allow you to clear all links" do
        VCR.use_cassette('clear task links for simple task') do
          @task.task_links.should == []
          @task.add_task_link(@link)

          @task.save
          @task.task_links = []
          @task.save
          @task.reload
          @task.task_links.length.should == 0
        end
      end
    end
  end




end
