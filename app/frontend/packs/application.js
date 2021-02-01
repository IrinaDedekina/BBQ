import Rails from "@rails/ujs"

Rails.start()

import "bootstrap/dist/js/bootstrap"
import "../styles/application"

const images = require.context("../images", true)
