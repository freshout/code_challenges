require 'ruby-debug'

class SeaportTerminal

  # Stacks containers in the best possible way and returns the amount of stacks needed
  #
  # @return [Number] minimum amount of stacks
  def stack_containers
    stacks = { }
    
    problem_count = 1
    File.open(@source_file) do |f|
      f.each_line do |line|
        containers_input = line.chomp
        stacks["case_#{problem_count}"] = minimum_stacks_for(containers_input)
        problem_count += 1
      end
    end

    stacks
  end

  private

  # Initializes the object loading the source file into
  #
  # @param [String] source the url of the input file.
  # @private
  def initialize(source)
    @source_file = source
  end

  def minimum_stacks_for(containers_input)
    total_containers = { }

    # Collect total containers for that row
    ("A".."Z").each {|name| total_containers[name] = 0}
    containers_input.each_char {|name| total_containers[name] = total_containers[name] + 1}

    stacks = Stacks.new(total_containers)

    containers_input.each_char do |container|
      stacks.push(container)
    end

    stacks.size
  end

end

class Stacks
  def initialize(num_containers)
    @num_containers = num_containers.clone
    @stacks = []
  end

  def size
    @stacks.size
  end

  def push(container)
    is_on_stack = false
    until is_on_stack
      stack_count = 0
      while (stack_count < @stacks.length) && (not is_on_stack)
        if @stacks[stack_count].can_push?(container)
          @stacks[stack_count].push(container)          
          is_on_stack = true
        else
          stack_count += 1
        end
      end
      unless is_on_stack
        @stacks << Stack.new(self, container)
        is_on_stack = true
      end
    end
    @stacks = @stacks.sort_by {|s| s.top_container}
  end
  
  def decrement_count(container)
    @num_containers[container] = @num_containers[container] - 1
  end

  def there_are_more?(container)
    @num_containers[container] > 0 ? true : false
  end
end

class Stack
  attr_reader :top_container
  
  def initialize(parent, container = nil)
    @parent = parent
    if container
      push(container)
      return true
    end
  end

  def can_push?(container)
    # this is for performance
    return true if @top_container == container
    return false if @top_container < container || @parent.there_are_more?(@top_container)
    return true
  end

  def push(container)
    @top_container = container
    @parent.decrement_count(container)
  end
end
