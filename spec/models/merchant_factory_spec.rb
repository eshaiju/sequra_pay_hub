# frozen_string_literal: true

RSpec.describe MerchantFactory do
  describe '.build' do
    it 'creates and saves a merchant record' do
      expect do
        described_class.build(row: row)
      end.to change(Merchant, :count).by(1)

      merchant = Merchant.last
      expect(merchant.reference).to eq('Merchant Ref')
      expect(merchant.email).to eq('merchant@example.com')
      expect(merchant.live_on).to eq(Date.new(2022, 1, 1))
      expect(merchant.disbursement_frequency).to eq('weekly')
      expect(merchant.minimum_monthly_fee).to eq(29.0)
    end

    it 'creates and saves a merchant record and does not create duplicates' do
      expect do
        described_class.build(row: row)
      end.to change(Merchant, :count).by(1)

      expect do
        described_class.build(row: row)
      end.not_to change(Merchant, :count)
    end
  end

  private

  def row
    { 'reference' => 'Merchant Ref', 'email' => 'merchant@example.com', 'live_on' => '2022-01-01',
      'disbursement_frequency' => 'WEEKLY', 'minimum_monthly_fee' => '29.0' }
  end
end
