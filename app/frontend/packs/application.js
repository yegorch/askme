require("@rails/ujs").start()
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import '../styles/application'

const images = require.context('../images', true)
