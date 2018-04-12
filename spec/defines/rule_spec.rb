require 'spec_helper'

describe 'sudo::rule' do
  let(:title) { 'admin' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    
    context "expected defaults" do
      it { is_expected.to contain_augeas('admin').with('context' => '/files/etc/sudoers') }
      it { is_expected.to contain_augeas('admin').with('lens'    => 'Sudoers.lns') }
    end
  end
end
