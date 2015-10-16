class CombinedOrderedEnumerator < Enumerator
  class UnorderedEnumerator < RuntimeError
    attr_reader :enumerator

    def initialize(enumerator)
      @enumerator = enumerator
    end
  end

  def initialize(*enumerators)
    @enumerators  = enumerators
    
    super() do |yielder| 
      while enumerators.any?
        remove_empty_enumerators && next
        raise UnorderedEnumerator.new(active_enumerator) unless on_ascending_order? 

        yielder.yield value
      end
    end
  end

  private

  attr_accessor :enumerators
  attr_reader   :last_value
  
  def value
    @last_value = active_enumerator.next
  end

   def active_enumerator
    enumerators.sort_by(&:peek).first
  end

  def remove_empty_enumerators
    enumerators.reject! { |enumerator| is_empty? enumerator }
  end

  def is_empty?(enumerator)
    enumerator.peek && false
  rescue StopIteration
    true
  end
  
  def on_ascending_order? 
    last_value_saved =  last_value || NullValue.new

    last_value_saved <= active_enumerator.peek
  end
end

class NullValue
  def <= other
    true
  end
end