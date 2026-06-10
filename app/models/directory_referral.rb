diff --git a/app/models/directory_referral.rb b/app/models/directory_referral.rb
index 0000000..e69de29
+++ b/app/models/directory_referral.rb
class DirectoryReferral < ApplicationRecord
  belongs_to :directory
  belongs_to :referral

  def self.update_counts
    # Update visitor counts daily
    update_visitor_counts
  end

  private

  def self.update_visitor_counts
    # Update visitor counts for each connected directory
    DirectoryReferral.all.each do |referral|
      referral.update_count
    end
  end

  def update_count
    # Update visitor count for the current directory
    directory.visitor_count += 1
    directory.save
  end
end