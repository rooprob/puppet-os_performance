require 'spec_helper'

describe 'os_performance::network' do
  context 'enabled' do
    let(:params) do
      {
        ensure: 'present'
      }
    end
    describe 'sets network parameters' do
      it { is_expected.to contain_sysctl('net.ipv4.ip_local_port_range').with_ensure('present') }
    end
  end
  context 'disabled' do
    let(:params) do
      {
        ensure: 'absent'
      }
    end
    describe 'sets network parameters' do
      it { is_expected.to contain_sysctl('net.ipv4.ip_local_port_range').with_ensure('absent') }
    end
  end
end
