require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  context 'with a new family' do
    setup {@family = Family.new}
    
    should 'not be valid' do
      assert_not_valid @family
      assert_not_nil @family.errors.on(:password)
      assert_not_nil @family.errors.on(:name)
    end
    
    context 'with a valid unsaved record' do
      setup do
        @family.attributes = {
          :password => "PASS",
          :password_confirmation => "PASS",
          :name => "Smith"
        }
      end
      
      should 'be valid' do
        assert_valid @family
      end

      context 'after save' do
        setup { @family.save! }
        
        should 'populate crypted password' do
          assert_not_nil @family.crypted_password
        end
        
        should 'authenticate against the correct password' do
          assert @family.authenticated?('PASS')
        end
        
        should 'authenticate case insensitively' do
          assert @family.authenticated?('pass')
        end
        
        should 'not authenticate against the incorrect password' do
          assert ! @family.authenticated?("not my password")
        end
      end
    end
  end
end
