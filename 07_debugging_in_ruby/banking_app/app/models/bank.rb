class Bank < ActiveRecord::Base
  has_many :accounts
  # distinct is added here so we don't get duplicate
  # users for users who have more than one account
  # at a particular bank
  # https://guides.rubyonrails.org/v6.1/association_basics.html#scopes-for-has-many-distinct
  has_many :users, -> { distinct }, through: :accounts

  def open_account(user, label, account_type, opening_deposit)
    Account.create(
      user: user,
      bank: self,
      label: label,
      balance: opening_deposit,
      account_type: account_type
    )
  end

  def accounts_summary(user)
    Account.where(user_id: user.id, bank_id: self.id).map do |acct|
      acct.summary
    end
  end

  def blacklist(user)
    Account.where(user_id: user.id, bank_id: self.id).destroy_all
  end
end