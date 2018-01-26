module EmosHelper

  def positive_dom(n)
    if n == 0
      dom = 'positive-a'
    elsif n == 1
      dom = 'positive-b'
    end
    return dom
  end


  def negative_dom(n)
    if n == 0
      dom = 'negative-a'
    elsif n == 1
      dom = 'negative-b'
    end
    return dom
  end

end
