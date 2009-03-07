module Convenience
  # convenience helpers, these methods are basically shortcuts to the should methods
  
  # shortcut for should.not.be.nil
  # has :page_title => assigns(:page_title).should.not.be.nil
  def has(var)
    assigns(var).should.not.be.nil
  end
  
end

Test::Unit::TestCase.send(:include, Convenience)