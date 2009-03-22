module Test::Spec::Rails::UseController
  module InstanceMethod
    # Setup controller for tests.
    # For example:
    #   context "Tuxie" do
    #     setup do 
    #       use_controller UsersController
    #       login_as users(:tuxie)
    #     end
    #     specify "should be able to see his profile" { ... }
    #   end
    
    # OR
    # to save some keystrokes you can use a symbolized version of the controller name
    # without the 'Controller' suffix
    # For example:
    #   context "Tuxie" do
    #     setup do 
    #       use_controller :users
    #       login_as :tuxie
    #     end
    #     specify "should be able to see his profile" { ... }
    #   end

    def use_controller(controller)
      controller = eval("#{controller.to_s.camelize}Controller") if controller.is_a? Symbol
      controller.class_eval { def rescue_action(e); raise e; end }
      @controller = controller.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end
  end

  module ClassMethod
    # Setup context for controller testing. For example:
    #   context "If not logged in" do
    #     use_controller SessionsController
    #     specify "one should see the login box" do
    #       get :new
    #       page.should.select "form#login"
    #     end
    #   end
    def use_controller(controller)
      setups << lambda { use_controller(controller) }
    end
  end
end


Test::Spec::TestCase::ClassMethods.send(:include, Test::Spec::Rails::UseController::ClassMethod)

if defined?(ActiveSupport::TestCase)
  ActiveSupport::TestCase.send(:include, Test::Spec::Rails::UseController::InstanceMethod)
else
  Test::Unit::TestCase.send(:include, Test::Spec::Rails::UseController::InstanceMethod)
end
