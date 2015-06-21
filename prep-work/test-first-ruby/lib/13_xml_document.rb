class XmlDocument

  def initialize indent = false
    @indent = indent
    @depth = -1
  end

  def method_missing method_name, args = {}, &block
    @depth += 1
    idt = "  " * @depth if @indent
    if !block.nil?
      return "#{idt}#{open_tag method_name, args}#{block.call}#{idt}#{close_tag method_name}"
    else
      return "#{idt}#{standalone_tag method_name, args}"
    end
  end

  private    

    def open_tag string, args
      "<#{string}#{stringize_args args}>#{"\n" if @indent}"
    end

    def close_tag string
      "</#{string}>#{"\n" if @indent}"
    end

    def standalone_tag string, args
      "<#{string}#{stringize_args args}/>#{"\n" if @indent}"
    end

    def stringize_args args
      return "" if args.nil?
      args.map { |key, val| " #{key}=\'#{val}\'" }.join("")
    end

end
