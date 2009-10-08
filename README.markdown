test/spec/rails
---------------

This plugin contain some helpers to test your Rails app using test/spec.

Installation
------------

 * Install test/spec: gem install test-spec
 * Install test/spec/rails
 * require 'test/spec/rails' in your test_helper.rb


Dependencies
------------

If you want to run the plugin's tests, you'll need these gems:

 * multi_rails
 * mocha

Then run "rake test:multi_rails:all" from the root of the project. The tests will be
executed against each version of Rails you have installed on your system.


Source
------

  test/spec/rails uses Git for source control. If you're running edge Rails you can install with:

      script/plugin install git://github.com/pelargir/test_spec_on_rails.git

  Otherwise just clone the project directly:

      git clone git://github.com/pelargir/test_spec_on_rails.git vendor/plugins/test_spec_on_rails


Model validation
----------------

      @user.should.validate
      @user.should.not.validate
      
      OR:
      
      @user.should.be.validated
      @user.should.not.be.validated


Redirection
-----------

      response.should.be.redirected           # assert_response :redirect
      response.should.redirect foo_url(@foo)  # assert_redirected_to foo_url(@foo)
      should.redirect_to :action => 'show'    # because "response" is optional
  
  It's aliased as redirect, redirect_to, redirected and redirected_to


Output verification
-------------------

  Wrapper for assert_select:
  
      get :show
      page.should.select "form#user_form" # require the output to have a <form id="user_form">
      # you can also do:
      page.should.have "form#user_form"
      page.should.contain "form#user_form"
      
      page.should.select "form#user_form" do |form|
        # the user_form must include a <input type="submit">
        form.should.select "input[type=submit]"       
      end


HTTP Status
-----------

  Wrapper for assert_response:

      status.should.be :success
      status.should.be 200


Which template was rendered?
----------------------------

  Wrapper for assert_template:
  
      template.should.be "foo/show.rhtml"


Which layout used?
------------------

  Wrapper for asserting that a certain layout is used:
  
      layout.should.be "foo"


URL testing
-----------

      get :show, :user_id => 1
      url.should.be "/users/1"
      url.should.be :controller => "users", :action => "show", :user_id => 1
      

Difference
----------

  Wrapper for assert_difference:
  
      Article.should.differ(:count).by(2) { blah }


Routing to set of url options from a given path (i.e., #assert_generates)
-------------------------------------------------------------------------

      assert_generates "/users/1", :controller => "users", :action => "show", :id  => "1"
    
  BECOMES 

      {:controller => "users", :action => "show", :id  => "1"}.should.route_to "/users/1"


Routing from a set of url options to an expected path (i.e., #assert_recognizes)
--------------------------------------------------------------------------------

      assert_recognizes({:controller => "users", :action => "show", :id => "1"}, {:path => "/users/1", :method => :get})

  BECOMES

      {:path => "/users/1", :method => :get}.should.route_from :controller => "users", :action => "show", :id =>"1"


Setup controller for testing + example usage
--------------------------------------------

      context "A guest" do
        use_controller FooController # => you can also do use_controller :foo
    
        specify "isn't allowed to foo" do
          post :create, :foo => 'bar'
          flash[:error].should.not.be.blank
          response.should.redirect :controller => 'front', :action => 'show'
          assigns(:foo).errors.on(:bar).should.not.be.blank
          assigns(:foo).should.not.validate
          follow_redirect
          page.should.select "#errors", :text => /#{flash[:error]}/
        end
      end
  
      context "Tuxie" do
        setup do
          use_controller FooController
          login_as :tuxie
        end
    
        specify "may foo" do
          post :create, :foo => 'bar'
          flash[:notice].should.not.be.blank
          assigns(:foo).errors.should.be.empty
          assigns(:foo).should.validate
          should.redirect_to :action => 'show'
          follow_redirect
          page.should.select "#notice", :text => /#{flash[:notice]}/
        end
      end


Misc
----

  page, response and request are just aliases for self (the TestCase) so the following
  are functionally identical:
  
      page.should.redirect
      response.should.redirect
      request.should.redirect
  
  output, body, html and xhtml return @response.body so the following lines are identical:
  
      output.should.match /foo/
      html.should.match /foo/
      xhtml.should.match /foo/
      body.should.match /foo/
  
  If an object respond to #should_equal, that method will be used instead of assert_equal
  when using foo.should.equal(bar) or foo.should.be(bar)
  foo.should.not.equal and foo.should.not.be look for #should_not_equal


Convenience and Shortcut methods
--------------------------------

Typing in should.not.be.nil all the time can be tiresome and overwhelming, here are some shortcuts that you can use.

    INSTEAD OF:
    
      assigns(:var).should.not.be.nil
    
    DO:
  
      has(:var) # => assigns(:var).should.not.be.nil
    
    OR pass multiple variables to test:
    
      has :var, :page_title # => assigns(:var).should.not.be.nil
                            # => assigns(:page_title).should.not.be.nil

Likewise you can test for the non existence of the variable using cant_have :

   INSTEAD OF:
   
      assigns(:var).should.be.nil
      
   DO:    
   
      cant_have :var
      
   OR pass multiple variables to test:
  
      cant_have :var, :page_title
  
Shortcuts for checking on flash values:

   INSTEAD OF:
    
      flash[:notice].should.not.be.nil
      
   DO: 
    
      has_flash :notice

Sometimes you might want to set the HTTP_REFERER variable when testing response.should.redirect, here's
an easy way to do it:

    set_redirect_back "/your/path"
    
Credit
------

 * Created by Per "Tuxie" Wigren <per.wigren@gmail.com>
 * Enhanced by Rick Olson <technoweenie@gmail.com>
 * Currently maintained by Matthew Bass <pelargir@gmail.com>
