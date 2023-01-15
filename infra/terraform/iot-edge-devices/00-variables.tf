variable "prefix" {
  type = string
  default = "gbb"
}

variable location {
    type = string
    default = "eastus"
}

variable "iot-edge-device-count" {
  type = number
  default = 2
}