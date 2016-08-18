class XmlDocument
  def initialize(indent=false)
    @indent = indent
  end

  def method_missing(*args, &prc)
    build_tag(*args, &prc)
  end

  def build_tag(name, options={}, &prc)
    start_tag(name, options, &prc) + content(&prc) + end_tag(name, &prc)
  end

  private
  def start_tag(name, options={}, &prc)
    tag = "<#{name}"

    options.each do |key, value|
      tag << " #{key}=\"#{value}\""
    end

    tag += ">#{@indent ? "\n":""}" if block_given?

    tag
  end

  def content(&prc)
    text = ""

    if block_given?
      yield.each_line do |line|
        text << "  " if @indent
        text << line
      end
    end

    text
  end

  def end_tag(name, &prc)
    return "</#{name}>#{@indent ? "\n":""}" if block_given?
    "/>#{@indent ? "\n":""}"
  end
end
