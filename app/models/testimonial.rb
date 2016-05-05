class Testimonial < ActiveRecord::Base
    belongs_to :user
    
    def self.get_all_testimonials
        self.all.order("created_at DESC")
    end
end
