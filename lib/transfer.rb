class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver,amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.valid? && @status != "complete" && sender.balance > self.amount
        sender.balance -= self.amount
        receiver.deposit(self.amount)
        @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.execute_transaction #&& @status != "reversed" #executed transfer was done
      receiver.balance -= self.amount
      sender.deposit(self.amount)
      @status = "reversed"
    end
  end
end
