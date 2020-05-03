# frozen_string_literal: true

class SnackBox
  SNACK_BOX_DATA = {
    1 => {
      'bone' => {
        'info' => 'Phoenician rawhide',
        'tastiness' => 20
      },
      'kibble' => {
        'info' => 'Delicately braised hamhocks',
        'tastiness' => 33
      },
      'treat' => {
        'info' => 'Chewy dental sticks',
        'tastiness' => 40
      }
    },
    2 => {
      'bone' => {
        'info' => 'An old dirty bone',
        'tastiness' => 2
      },
      'kibble' => {
        'info' => 'Kale clusters',
        'tastiness' => 1
      },
      'treat' => {
        'info' => 'Bacon',
        'tastiness' => 80
      }
    },
    3 => {
      'bone' => {
        'info' => 'A steak bone',
        'tastiness' => 64
      },
      'kibble' => {
        'info' => 'Sweet Potato nibbles',
        'tastiness' => 45
      },
      'treat' => {
        'info' => 'Chicken bits',
        'tastiness' => 75
      }
    }
  }.freeze
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def get_bone_info(box_id)
    @data[box_id]['bone']['info']
  end

  def get_bone_tastiness(box_id)
    @data[box_id]['bone']['tastiness']
  end

  def get_kibble_info(box_id)
    @data[box_id]['kibble']['info']
  end

  def get_kibble_tastiness(box_id)
    @data[box_id]['kibble']['tastiness']
  end

  def get_treat_info(box_id)
    @data[box_id]['treat']['info']
  end

  def get_treat_tastiness(box_id)
    @data[box_id]['treat']['tastiness']
  end
end

class CorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  # def bone
  #   info = @snack_box.get_bone_info(@box_id)
  #   tastiness = @snack_box.get_bone_tastiness(@box_id)
  #   result = "Bone: #{info}: #{tastiness} "
  #   tastiness > 30 ? "* #{result}" : result
  # end

  # def kibble
  #   info = @snack_box.get_kibble_info(@box_id)
  #   tastiness = @snack_box.get_kibble_tastiness(@box_id)
  #   result = "Kibble: #{info}: #{tastiness} "
  #   tastiness > 30 ? "* #{result}" : result
  # end

  # def treat
  #   info = @snack_box.get_treat_info(@box_id)
  #   tastiness = @snack_box.get_treat_tastiness(@box_id)
  #   result = "Treat: #{info}: #{tastiness} "
  #   tastiness > 30 ? "* #{result}" : result
  # end
end

class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id

    # blok będzie wykonany dla każdego wyniku
    @snack_box.methods.grep(/^get_(.*)_info$/) { MetaCorgiSnacks.define_snack Regexp.last_match(1) }
  end

  # part 1
  # Hint: Within #method_missing use #send to call methods on your @snack_box. You can interpolate to get the method name, and then pass the method name to #send
  # def method_missing(name, *_args)
  #   info_method_name = "get_#{name}_info"
  #   tastiness_method_name = "get_#{name}_tastiness"

  #   info = @snack_box.send(info_method_name, @box_id)
  #   tastiness = @snack_box.send(tastiness_method_name, @box_id)
  #   result = "Treat: #{info}: #{tastiness} "
  #   tastiness > 30 ? "* #{result}" : result
  # end

  def self.define_snack(name)
    # Your code goes here...
    define_method(name) do
      info_method_name = "get_#{name}_info"
      tastiness_method_name = "get_#{name}_tastiness"

      info = @snack_box.send(info_method_name, @box_id)
      tastiness = @snack_box.send(tastiness_method_name, @box_id)
      result = "#{name}: #{info}: #{tastiness} "
      tastiness > 30 ? "* #{result}" : result
    end

    nil
  end

  # methods on our @snack_box.
  # snack_methods = @snack_box.methods.grep(/^get_(.*)_info$/)
  # snack_methods

  # define_snack :bone
  # define_snack :kibble
  # define_snack :treat
end
