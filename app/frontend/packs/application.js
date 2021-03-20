import Rails from "@rails/ujs"

Rails.start()

import "bootstrap/dist/js/bootstrap"
import "../styles/application"
import "bootstrap-icons/font/bootstrap-icons"
import "../scripts/map"

const images = require.context("../images", true)
