variable "compute_type" {
  description = "Information about the compute resources the build project will use.\nAvailable values for this parameter are: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE or BUILD_GENERAL1_2XLARGE."
  default = "BUILD_GENERAL1_LARGE"
}

variable "source_location" {
  description = "Github repo URL (HTTPS)"
  default     = "https://github.com/getndazn/apollo-load-test.git"
}

variable "build_timeout" {
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes."
  default     = "120"
}

variable "target_env" {
  description = "Wich environment is tested: dev, test, stage, prod"
  default     = "stage"
}

variable "test_type" {
  description = "The performance test type: load, baseline, spike, endurance"
  default     = "load"
}

variable "max_users" {
  description = "Maximal number of virtual users"
  default     = "100"
}

variable "load_duration" {
  description = "Maximal workload duration. Measurment: seconds"
  default     = "600"
}

variable "user_think_time" {
  description = "Delay between the user actions (usually http requests). Measurement: seconds"
  default     = "1"
}

variable "source_version" {
  description = "A version of the build input to be built for this project. If not specified, the latest version is used."
  default = "master"
}

variable "ramp_up_duration" {
  description = "Duration of virtual users ramp-up"
  default = "120"
}

variable "ramp_down_duration" {
  description = "Duration of virtual users ramp-down"
  default = "120"
}
