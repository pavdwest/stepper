# Overview

A very simple sequential, extensible task execution framework.
(It's technically a DAG :P but yeah it's just a list of tasks to run in serial)

# Details

* Task (`task.rb`): A small unit of work. Note that output of a parent is passed to the child.
* Process: (`process.rb`): A collection of sequential tasks to be performed

Simple example of a process is defined in `data/simple_example_process.yaml`

General:

* Define your process with multiple Tasks
* Extend `Tasks` class to implement the behaviour of the Tasks
* Create an instance of `Process` and pass in the process yaml file
* Profit?

# How to run

Just run `stepper.rb` with Ruby
