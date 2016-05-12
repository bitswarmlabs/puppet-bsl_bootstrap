require 'spec_helper'
describe 'bsl_bootstrap' do

  context 'with default values for all parameters' do
    it { should contain_class('bsl_bootstrap') }
  end
end
