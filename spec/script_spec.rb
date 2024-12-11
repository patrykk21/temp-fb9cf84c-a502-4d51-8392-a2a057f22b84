require_relative '../lib/script'
require 'active_support/core_ext/hash/indifferent_access'

RSpec.describe Script do
  let(:example) do
    [
      { "event": 'subscription', "account": 'A001', "date": '2020-01-15' },
      { "event": 'subscription', "account": 'B0001', "date": '2020-01-23' },
      { "event": 'subscription', "account": 'C001', "date": '2020-01-25' },
      { "event": 'reactivation', "account": 'B0001', "date": '2020-04-01' },
      { "date": '2020-02-23', "account": 'B0001', "event": 'cancellation' },
      { "date": '2020-04-03', "account": 'B0001', "event": 'cancellation' },
      { "event": 'reactivation', "account": 'B0001', "date": '2020-05-12' },
      { "date": '2020-06-18', "account": 'B0001', "event": 'cancellation' },
      { "date": '2020-03-10', "account": 'C001', "event": 'cancellation' },
      { "event": 'reactivation', "account": 'C001', "date": '2020-05-17' }
    ].map!(&:with_indifferent_access)
  end

  describe '.find_reactivations' do
    let(:subject) { described_class.find_reactivations(example) }

    it { is_expected.to eq(%w[B0001 C001]) }
  end

  describe '.find_reactivations_v2' do
    let(:subject) { described_class.find_reactivations_v2(example) }

    it { is_expected.to eq(%w[B0001 C001]) }
  end

  describe '.find_more_than_one_cancellation' do
    let(:subject) { described_class.find_more_than_one_cancellation(example) }

    it { is_expected.to eq(%w[B0001]) }
  end

  describe '.find_more_than_one_cancellation_v2' do
    let(:subject) { described_class.find_more_than_one_cancellation_v2(example) }

    it { is_expected.to eq(%w[B0001]) }
  end
end
