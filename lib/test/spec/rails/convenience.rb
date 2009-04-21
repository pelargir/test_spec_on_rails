module Convenience
  # convenience helpers, these methods are basically shortcuts to the should methods
  
  # shortcut for should.not.be.nil
  # has :page_title => assigns(:page_title).should.not.be.nil
  # OR you can also pass an array of values 
  # has :page_title, :user # => assigns(:page_title).should.not.be.nil
                           # => assigns(:user).should.not.be.nil 
  def has(*var)
    return assigns(var).should.not.be.nil if var.length == 1
    var.each { |v| assigns(v).should.not.be.nil }
  end

  # shortcut for should.be.nil
  # cant_have :page_title => assigns(:page_title).should.be.nil
  def cant_have(var)
    assigns(var).should.be.nil
  end
  
  # shortcut for flash[:type].should.not.be.nil
  # has_flash :notice => assigns(flash[:notice]).should.not.be.nil
  def has_flash(flash_type)
    flash[flash_type].should.not.be.nil
  end
  
end

Test::Unit::TestCase.send(:include, Convenience)