# frozen_string_literal: true

root = ::File.dirname(__FILE__)
require ::File.join(root, 'base')
# -------------------------------------------
require ::File.join(root, 'main/first')
require ::File.join(root, 'main/second')
# -------------------------------------------
require ::File.join(root, 'more/first')

# -------------------------------------------
require ::File.join(root, 'paginate/first')
require ::File.join(root, 'paginate/second')
