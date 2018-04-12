require 'spec_helper'

describe 'sudo::rule' do
  let(:title) { 'admin' }
  let(:params) { {} }

  on_supported_os.each do
    context 'expected defaults' do
      it { is_expected.to contain_augeas('admin').with('context' => '/files/etc/sudoers') }
      it { is_expected.to contain_augeas('admin').with('lens'    => 'Sudoers.lns') }
      it do
        is_expected.to contain_augeas('admin').with('changes' =>
          [
            "set spec[user = 'admin']/user 'admin'",
            "set spec[user = 'admin']/host_group/host 'ALL'",
            "set spec[user = 'admin']/host_group/command 'ALL'",
            "set spec[user = 'admin']/host_group/command/runas_user 'ALL'",
          ])
      end
    end
  end
end
