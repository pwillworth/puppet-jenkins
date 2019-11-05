require 'spec_helper'

describe 'jenkins::user', type: :define do
  let(:title) { 'foo' }
  let(:facts) do
    {
      osfamily: 'RedHat',
      operatingsystem: 'RedHat',
      operatingsystemrelease: '6.7',
      operatingsystemmajrelease: '6'
    }
  end

  describe 'example user' do
    let(:params) { { email: 'foo@example.org', password: 'foo' } }

    it do
      is_expected.to contain_jenkins__user('foo').
        that_requires('Class[jenkins::cli_helper]')
    end
    it do
      is_expected.to contain_jenkins__user('foo').
        that_comes_before('Anchor[jenkins::end]')
    end

    it {
      is_expected.to contain_jenkins__cli__exec('create-jenkins-user-foo').with(command: ['create_or_update_user', title.to_s, 'foo@example.org',
                                                                                          "'Sensitive [value redacted]'", "'Managed by Puppet'", "''"])
    }
  end
end
