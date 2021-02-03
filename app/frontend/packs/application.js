import Rails from "@rails/ujs"

Rails.start()

import "bootstrap/dist/js/bootstrap"
import "../styles/application"
import "bootstrap-icons/font/bootstrap-icons"

const images = require.context("../images", true)
