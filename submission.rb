# Flag paid submissions for priority polling
def priority_polling?
  self.paid? && self.priority_polling
end

def paid?
  self.status == 'Priority'
end