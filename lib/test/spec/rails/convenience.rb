module Convenience
  # convenience helpers, these methods are basically shortcuts to the should methods
  
  # shortcut for should.not.be.nil
  # has :page_title => assigns(:page_title).should.not.be.nil
  def has(var)
    assigns(var).should.not.be.nil
  end
  
  # shortcut for flash[:type].should.not.be.nil
  # has_flash :notice => assigns(flash[:notice]).should.not.be.nil
  def has_flash(flash_type)
    flash[flash_type].should.not.be.nil
  end
  
end

Test::Unit::TestCase.send(:include, Convenience)