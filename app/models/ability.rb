class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin == true
      # can :manage, :all
    end
    
    # get permission from group
    # Object.const_get("Article")
    UserGroup.permission_classes.each do |row|
        model_class = row[:class_name]
      
        # break if can get Class from string
        begin
          model = Object.const_get(model_class)
        rescue => ex
          break
        end
        
        # check for read ability
        if user.ability(model_class, "read").include?('yes')
          can :read, model
        end
        
        # check for create ability
        if user.ability(model_class, "create").include?('yes')
          can :create, model
        end
        
        # check for update ability
        abilities = user.ability(model_class, "update")
        can :update, model do |item|       
          result = false
          if abilities.include?('yes')
            result = true
            if abilities.include?('own')
              result &&= (user.id == item.user_id)
            end
            if abilities.include?('not_own')
              result &&= (user.id != item.user_id)
            end
            if abilities.include?('approved')
              result &&= item.approved
            end
            if abilities.include?('not_approved')
              result &&= !item.approved
            end
          end
          result
        end
        
        # check for delete ability
        delete_abilities = user.ability(model_class, "delete")
        can :delete, model do |item|       
          result = false
          if delete_abilities.include?('yes')
            result = true
            if delete_abilities.include?('own')
              result &&= (user.id == item.user_id)
            end
            if delete_abilities.include?('not_own')
              result &&= (user.id != item.user_id)
            end
            if delete_abilities.include?('approved')
              result &&= item.approved
            end
            if delete_abilities.include?('not_approved')
              result &&= !item.approved
            end
          end
          result
        end
        
        # check for approve ability
        approve_abilities = user.ability(model_class, "approve")
        can :approve, model do |item|       
          result = false
          if approve_abilities.include?('yes')
            result = !item.approved
            if approve_abilities.include?('own')
              result &&= (user.id == item.user_id)
            end
            if approve_abilities.include?('not_own')
              result &&= (user.id != item.user_id)
            end
          end
          result
        end
              
    end
    
    ## if current user is user
    #if user.role == 'user' or user.role == 'manager' or user.role == 'admin'
    #  # Cancan - Product
    #    can [:read, :create], Product
    #    can :update, Product do |item|
    #      user.id == item.user_id && item.approved == false
    #    end
    #    can :delete, Product do |item|
    #      user.id == item.user_id && item.approved == false
    #    end
    #  # Cancan - Category
    #    can [:read], Category
    #  # Cancan - Manufacturer
    #    can [:read], Manufacturer
    #end
    #
    ## if current user is manager
    #if user.role == 'manager' or user.role == 'admin'
    #  # Cancan - Product
    #    can :update, Product do |item|
    #      item.approved == false
    #    end
    #    can :delete, Product do |item|
    #      item.approved == false
    #    end
    #    can :approve, Product do |item|
    #      item.approved == false
    #    end
    #  # Cancan - Category
    #  # Cancan - Manufacturer
    #    can [:create, :update], Manufacturer
    #    
    #end
    #
    ## if current user is admin
    #if user.role == 'admin'
    #  # Cancan - Product
    #    can :update, Product
    #    can :delete, Product
    #    can :approve, Product do |item|
    #      item.approved == false
    #    end
    #  # Cancan - Category
    #    can [:create, :update, :delete], Category
    #  # Cancan - Manufacturer
    #    can [:delete], Manufacturer
    #end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
