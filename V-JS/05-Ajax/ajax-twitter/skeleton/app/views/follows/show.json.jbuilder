# frozen_string_literal: true

json.call(@follow, *Follow.column_names)
# is the same as json.(@follow, attributes)

# json.extract! @follow
# File 'lib/jbuilder.rb', line 224

# def call(object, *attributes, &block)
#   if ::Kernel.block_given?
#     array! object, &block
#   else
#     extract! object, *attributes
#   end
# end
