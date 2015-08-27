require 'spec_helper'

describe 'os_performance' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "os_performance class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('os_performance::network') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'os_performance class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('os_performance') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
