require 'spec_helper'
describe 'munki_prefs' do
  context 'with default values for all parameters' do
    it { should contain_class('munki_prefs') }
  end
end
